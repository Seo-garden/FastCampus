//
//  HomeViewController.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit
import SwiftUI
import Combine


class HomeViewController: UIViewController {
    enum Section: Int {
        case banner
        case horizontalProductItem
        case verticalProductItem
        //        case theme
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?  //dataSource 값을 만들때는 컬렉션뷰가 필요한데, collectionView 가 생성된 후에 사용할 수 있어서 viewDidLoad() 이후에 값을 할당한다.
    private var compositinalLayout: UICollectionViewCompositionalLayout = setCompositinalLayout()
    private var viewModel: HomeViewModel = HomeViewModel()
    private var cancellables : Set<AnyCancellable> = []        //뷰컨트롤러가 사라질 때 사라진다.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        
        setDataSource()
        collectionView.collectionViewLayout = compositinalLayout
        
        viewModel.process(action: .loadData)
    }
    
    private static func setCompositinalLayout() -> UICollectionViewCompositionalLayout {        //static 으로 선언한 이유는 compositinalLayout 이 변수를 초기화할 때 내부메서드를 사용할 수 없는 상태인데, static 을 사용하게 될 경우 사용할 수 있다. 대신 safe 값을 사용할 수 있다.
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .banner:
                return HomeBannerCollectionViewCell.bannerLayout()
            case .horizontalProductItem:
                return HomeProductCollectionViewCell.horizontalProductItemLayout()
            case .verticalProductItem:
                return HomeProductCollectionViewCell.verticalProductItemLayout()
            case.none:
                return nil
            }}
    }
    
    private func bindingViewModel() {
        viewModel.state.$collectionViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in        //sink 에 경고를 띄우는 이유는 sink는 값을 관찰하기 때문에 수명을 정해줘야 한다.
                self?.applySnapshot()
            }.store(in: &cancellables)
    }
    
    private func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, viewModel in
            switch Section(rawValue: indexPath.section) {
            case .banner:
                return self?.bannerCell(collectionView, indexPath, viewModel)
            case .horizontalProductItem, .verticalProductItem:
                return self?.ProductItemCell(collectionView, indexPath, viewModel)
            case .none:
                return .init()
            }
        })
    }
    
    private func applySnapshot() {
        var snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {      //해당값이 API에서 값이 전혀 없다면 배너 조차 만들지 않음
            snapshot.appendSections([.banner])
            snapshot.appendItems(bannerViewModels, toSection: .banner)
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels {
            snapshot.appendSections([.horizontalProductItem])
            snapshot.appendItems(horizontalProductViewModels, toSection: .horizontalProductItem)
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapshot.appendSections([.verticalProductItem])
            snapshot.appendItems(verticalProductViewModels, toSection: .verticalProductItem)
        }
        
        dataSource?.apply(snapshot)
    }
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel, let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCollectionViewCell", for: indexPath) as? HomeBannerCollectionViewCell else { return .init()}
        
        cell.setViewModel(viewModel)
        
        return cell
    }
    
    private func ProductItemCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel, let cell: HomeProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionViewCell", for: indexPath) as? HomeProductCollectionViewCell else { return .init() }
        
        cell.setViewModel(viewModel)
        
        return cell
    }
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
