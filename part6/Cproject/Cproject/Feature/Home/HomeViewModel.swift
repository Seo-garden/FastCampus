//
//  HomeViewModel.swift
//  Cproject
//
//  Created by 서정원 on 7/26/24.
//

import Combine      //MVVM의 값을 바인딩을 할 수 있는 라이브러리
import Foundation


final class HomeViewModel {
    enum Action {
        case loadData
        case loadCoupon
        case getDataSuccess(HomeResponse)
        case getDataFailure(Error)
        case getCouponSuccess(Bool)
        case didTapCouponButton
        
    }
    final class State {
        struct CollectionViewModels {
            var bannerViewModels: [HomeBannerCollectionViewCellViewModel]?
            var horizontalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var verticalProductViewModels: [HomeProductCollectionViewCellViewModel]?
            var couponState: [HomeCouponButtonCollectionViewCellViewModel]?
            var separateLine1ViewModels: [HomeSpearateLineCollectionViewCellViewModel] = [HomeSpearateLineCollectionViewCellViewModel()]
            var separateLine2ViewModels: [HomeSpearateLineCollectionViewCellViewModel] = [HomeSpearateLineCollectionViewCellViewModel()]
        }
        @Published var collectionViewModels: CollectionViewModels = CollectionViewModels()      //값이 변경되면 알림이 되는 @Published
    }
    
    private(set) var state: State = State()
    private var loadDataTask: Task<Void, Never>?
    private let couponDownloadedKey : String = "CouponDownloaded"
    
    func process(action: Action) {
        switch action {
        case .loadData:
            loadData()
        case .loadCoupon:
            loadCoupon()
        case let .getDataSuccess(response):
            transformResponse(response)
        case let .getDataFailure(error):
            print("network error : \(error)")
        case let .getCouponSuccess(isDownloded):
            Task { await transformCoupon(isDownloded) }
        case .didTapCouponButton:
            downloadCoupon()
        }
    }
    
    
    deinit { loadDataTask?.cancel() }
    
    private func transformResponse(_ response: HomeResponse) {
        Task { await transformBanner(response) }  //각각 따로 동작해야 하기 때문에, Task 로 묶어준다.
        Task { await transforVerticalProduct(response) }
        Task { await transforHorizontalProduct(response) }
    }
}

//MARK: - lifecycle

extension HomeViewModel {
    private func loadData() {
        loadDataTask = Task {      //Task는 비동기쓰레드로 동작하기 때문에, ViewModel이 사라지더라도 Task는 마저 동작하기 때문에, deinit() 연기가 된다.
            do {
                let response = try await NetworkService.shared.getHomeData()    //getHomeData 는 async 를 이용해서 통신하기 때문에 Task 로 감싸줘야 한다.
                process(action: .getDataSuccess(response))
            } catch {
                process(action: .getDataFailure(error))
            }
        }
    }
    
    private func loadCoupon() {
        let couponState: Bool = UserDefaults.standard.bool(forKey: couponDownloadedKey)      //UserDefaults 의 경우 실패할 경우가 없다.
        process(action: .getCouponSuccess(couponState))
        
    }
    
    @MainActor      //메인에서 동작하게 만드는 어노테이션
    private func transformBanner(_ response: HomeResponse) async {
        state.collectionViewModels.bannerViewModels = response.banners.map {
            HomeBannerCollectionViewCellViewModel(bannerImageUrl: $0.imageUrl)
        }
    }
    
    
    @MainActor
    private func transforHorizontalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.horizontalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.horizontalProducts)
    }
    
    @MainActor
    private func transforVerticalProduct(_ response: HomeResponse) async {
        state.collectionViewModels.verticalProductViewModels = productToHomeProductCollectionViewCellViewModel(response.verticalProducts)
    }
    
    private func productToHomeProductCollectionViewCellViewModel(_ product: [Product]) -> [HomeProductCollectionViewCellViewModel] {
        return product.map {
            HomeProductCollectionViewCellViewModel(imageUrlString: $0.imageUrl, title: $0.title, reasonDiscountString: $0.discount, originalPrice: "\($0.originalPrice.moneyString)", disCountPrice: "\($0.discountPrice.moneyString)")
        }
    }
    
    @MainActor
    private func transformCoupon(_ isDownloded: Bool) async {
        state.collectionViewModels.couponState = [.init(state: isDownloded ? .disable : .enable)]
    }
    
    private func downloadCoupon() {
        UserDefaults.standard.setValue(true, forKey: couponDownloadedKey)
        process(action: .loadCoupon)
    }
}
