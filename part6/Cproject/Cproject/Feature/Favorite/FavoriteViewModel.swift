//
//  FavoriteViewModel.swift
//  Cproject
//
//  Created by 서정원 on 7/29/24.
//

import Foundation

//MVI 형태는 Action을 받아서 State 를 업데이트 한다.

final class FavoriteViewModel {
    enum Action {
        case getFavoriteFromAPI
        case getFavoriteSuccess(FavoritesResponse)
        case getFavoriteFailure(Error)
        case didTapPurchaseButton
    }
    
    final class State {
        @Published var tableViewModel: [FavoriteItemTableViewCellViewModel]?
    }
    
    private(set) var state: State = State()
    
    func process(_ action: Action) {
        switch action {
        case .getFavoriteFromAPI:
            getFavoriteFromAPI()
            break
        case .getFavoriteSuccess(let favoritesResponse):
            translateFavoriteItemViewModel(favoritesResponse)
        case .getFavoriteFailure(let error):
            print("debug: \(error)")
        case .didTapPurchaseButton:
            break
        }
    }
}

extension FavoriteViewModel {
    private func getFavoriteFromAPI() {
        Task {
            do {
                let response = try await NetworkService.shared.getFavoriteData()
                process(.getFavoriteSuccess(response))
            } catch {
                process(.getFavoriteFailure(error))
            }
        }
    }
    
    private func translateFavoriteItemViewModel(_ response: FavoritesResponse) {
        state.tableViewModel = response.favorites.map {
            FavoriteItemTableViewCellViewModel(imageUrl: $0.imageUrl, productName: $0.title, productPrices: $0.discountPrice.moneyString)
        }
    }
}
