//
//  HomeViewModel.swift
//  Cproject
//
//  Created by 서정원 on 7/26/24.
//

import Foundation
import Combine      //MVVM의 값을 바인딩을 할 수 있는 라이브러리

class HomeViewModel {
    @Published var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?       //값이 변경되면 알림이 되는 @Published
    @Published var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
    @Published var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
    
    private var loadDataTask: Task<Void, Never>?
    
    func loadData() {
        loadDataTask = Task {      //Task는 비동기쓰레드로 동작하기 때문에, ViewModel이 사라지더라도 Task는 마저 동작하기 때문에, deinit() 연기가 된다.
            do {
                let response = try await NetworkService.shared.getHomeData()    //getHomeData 는 async 를 이용해서 통신하기 때문에 Task 로 감싸줘야 한다.
                Task { await transformBanner(response) }  //각각 따로 동작해야 하기 때문에, Task 로 묶어준다.
                Task { await transforVerticalProduct(response) }
                Task { await transforHorizontalProduct(response) } 
                
                self.bannerViewModels = bannerViewModels
                self.horizontalProductViewModels = horizontalProductViewModels
                self.verticalProductViewModels = verticalProductViewModels
                
            } catch {
                print("network error : \(error)")
            }
        }
    }
    
    deinit { loadDataTask?.cancel() }
    
    @MainActor      //메인에서 동작하게 만드는 어노테이션
    private func transformBanner(_ response: HomeResponse) async {
        bannerViewModels = response.banners.map {
            HomeBannerCollectionViewCellViewModel(bannerImageUrl: $0.imageUrl)
        }
    }
    
    
    @MainActor
    private func transforHorizontalProduct(_ response: HomeResponse) {
        horizontalProductViewModels = response.horizontalProducts.map {
            HomeProductCollectionViewCellViewModel(imageUrlString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPrice: "\($0.originalPrice)", disCountPrice: "\($0.discountPrice)")
        }
    }
    
    @MainActor
    private func transforVerticalProduct(_ response: HomeResponse) {
        verticalProductViewModels = response.verticalProducts.map {
            HomeProductCollectionViewCellViewModel(imageUrlString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPrice: "\($0.originalPrice)", disCountPrice: "\($0.discountPrice)")
        }
    }
}
