//
//  HomeViewController.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit
import SwiftUI
import Combine


final class HomeViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>
    private typealias SnapShot = NSDiffableDataSourceSnapshot<Section, AnyHashable>
    
    private enum Section: Int {
        case banner
        case horizontalProductItem
        case separateLine1
        case couponButton
        case verticalProductItem
        case separateLine2
        case theme
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private lazy var dataSource: DataSource = setDataSource()  //dataSource 값을 만들때는 컬렉션뷰가 필요한데, collectionView 가 생성된 후에 사용할 수 있어서 viewDidLoad() 이후에 값을 할당한다.
    private lazy var compositinalLayout: UICollectionViewCompositionalLayout = setCompositinalLayout()
    private var viewModel: HomeViewModel = HomeViewModel()
    private var cancellables : Set<AnyCancellable> = []        //뷰컨트롤러가 사라질 때 사라진다.
    
    private var currentSection: [Section]  {
        dataSource.snapshot().sectionIdentifiers as [Section]
    }
    
    private var didTapCouponDownload: PassthroughSubject<Void, Never> = PassthroughSubject<Void, Never>()       //쿠폰 다운로드 버튼을 누르면 send 값이 넘어와서 관찰
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingViewModel()
        
        collectionView.collectionViewLayout = compositinalLayout
        collectionView.delegate = self
        viewModel.process(action: .loadData)
        viewModel.process(action: .loadCoupon)
    }
    
    private func setCompositinalLayout() -> UICollectionViewCompositionalLayout {        //static 으로 선언한 이유는 compositinalLayout 이 변수를 초기화할 때 내부메서드를 사용할 수 없는 상태인데, static 을 사용하게 될 경우 사용할 수 있다. 대신 safe 값을 사용할 수 있다.
        UICollectionViewCompositionalLayout { [weak self] section, _ in
            switch self?.currentSection[section] {
            case .banner:
                return HomeBannerCollectionViewCell.bannerLayout()
            case .horizontalProductItem:
                return HomeProductCollectionViewCell.horizontalProductItemLayout()
            case .couponButton:
                return HomeCouponButtonCollectionViewCell.couponButtonItemLayout()
            case .verticalProductItem:
                return HomeProductCollectionViewCell.verticalProductItemLayout()
            case .separateLine1, .separateLine2:
                return HomeSpearateLineCollectionViewCell.separateLineLayout()
            case .theme:
                return HomeThemeCollectionViewCell.themeLayout()
            case.none:
                return nil
            }}
    }
    
    private func bindingViewModel() {
        viewModel.state.$collectionViewModels.receive(on: DispatchQueue.main)
            .sink { [weak self] _ in        //sink 에 경고를 띄우는 이유는 sink는 값을 관찰하기 때문에 수명을 정해줘야 한다.
                self?.applySnapshot()
            }.store(in: &cancellables)
        didTapCouponDownload.receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.viewModel.process(action: .didTapCouponButton)
            }.store(in: &cancellables)
    }
    
    private func setDataSource() -> DataSource {
        let dataSource: DataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { [weak self] collectionView, indexPath, viewModel in
            switch self?.currentSection[indexPath.section] {
            case .banner:
                return self?.bannerCell(collectionView, indexPath, viewModel)
            case .horizontalProductItem, .verticalProductItem:
                return self?.ProductItemCell(collectionView, indexPath, viewModel)
            case .couponButton:
                return self?.couponButtonCell(collectionView, indexPath, viewModel)
            case .separateLine1, .separateLine2:
                return self?.separateLineCell(collectionView, indexPath, viewModel)
            case .theme:
                return self?.themeCell(collectionView, indexPath, viewModel)
            case .none:
                return .init()
            }
        })
        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader,
                  let viewModel = self?.viewModel.state.collectionViewModels.themeViewModels?.headerViewModel else { return nil }
            
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HomeThemeHeaderCollectionReusableView.reusableId, for: indexPath) as? HomeThemeHeaderCollectionReusableView
            headerView?.setViewModel(viewModel)
            
            return headerView
        }
        return dataSource
    }
    
    private func applySnapshot() {
        var snapshot: SnapShot = SnapShot()
        
        if let bannerViewModels = viewModel.state.collectionViewModels.bannerViewModels {      //해당값이 API에서 값이 전혀 없다면 배너 조차 만들지 않음
            snapshot.appendSections([.banner])
            snapshot.appendItems(bannerViewModels, toSection: .banner)
        }
        
        if let horizontalProductViewModels = viewModel.state.collectionViewModels.horizontalProductViewModels {
            snapshot.appendSections([.horizontalProductItem])
            snapshot.appendItems(horizontalProductViewModels, toSection: .horizontalProductItem)
            
            snapshot.appendSections([.separateLine1])
            snapshot.appendItems(viewModel.state.collectionViewModels.separateLine1ViewModels, toSection: .separateLine1)
        }
        
        
        if let couponViewModels = viewModel.state.collectionViewModels.couponState {
            
            snapshot.appendSections([.couponButton])
            snapshot.appendItems(couponViewModels, toSection: .couponButton)
        }
        
        if let verticalProductViewModels = viewModel.state.collectionViewModels.verticalProductViewModels {
            snapshot.appendSections([.verticalProductItem])
            snapshot.appendItems(verticalProductViewModels, toSection: .verticalProductItem)
        }
        
        if let themeViewModels = viewModel.state.collectionViewModels.themeViewModels?.items{
            snapshot.appendSections([.separateLine2])
            snapshot.appendItems(viewModel.state.collectionViewModels.separateLine2ViewModels, toSection: .separateLine2)
            
            snapshot.appendSections([.theme])
            snapshot.appendItems(themeViewModels, toSection: .theme)
        }
        
        dataSource.apply(snapshot)
    }
    private func bannerCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel,
              let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeBannerCollectionViewCell.reusableId, for: indexPath) as? HomeBannerCollectionViewCell else { return .init()}
        
        cell.setViewModel(viewModel)
        
        return cell
    }
    
    private func ProductItemCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel,
              let cell: HomeProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeProductCollectionViewCell.reusableId, for: indexPath) as? HomeProductCollectionViewCell else { return .init() }
        
        cell.setViewModel(viewModel)
        
        return cell
    }
    
    private func couponButtonCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeCouponButtonCollectionViewCellViewModel,
              let cell: HomeCouponButtonCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCouponButtonCollectionViewCell.reusableId, for: indexPath) as? HomeCouponButtonCollectionViewCell else { return .init() }
        
        cell.setViewModel(viewModel, didTapCouponDownload)
        return cell
    }
    
    private func separateLineCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeSpearateLineCollectionViewCellViewModel,
              let cell: HomeSpearateLineCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeSpearateLineCollectionViewCell.reusableId, for: indexPath) as? HomeSpearateLineCollectionViewCell else { return .init() }
        cell.setViewModel(viewModel)
        return cell
    }
    
    private func themeCell(_ collectionView: UICollectionView, _ indexPath: IndexPath, _ viewModel: AnyHashable) -> UICollectionViewCell {
        guard let viewModel = viewModel as? HomeThemeCollectionViewCellViewModel,
              let cell: HomeThemeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeThemeCollectionViewCell.reusableId, for: indexPath) as? HomeThemeCollectionViewCell else { return .init() }
        cell.setViewModel(viewModel)
        
        return cell
    }
    
    @IBAction func favoriteButtonAction(_ sender: UIBarButtonItem) {
        let favoriteStoryboard: UIStoryboard = UIStoryboard(name: "Favorite", bundle: nil)
        if let favoriteViewController = favoriteStoryboard.instantiateInitialViewController() {
            navigationController? .pushViewController(favoriteViewController, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch currentSection[indexPath.section] {
        case .banner:
            break
        case .separateLine1, .separateLine2:
            break
        case .couponButton:
            break
        case .horizontalProductItem, .verticalProductItem:
            let storyboard = UIStoryboard(name: "Detail", bundle: nil)
            guard let viewController: UIViewController = storyboard.instantiateInitialViewController() else { return }
            navigationController?.pushViewController(viewController, animated: true)
        case .theme:
            break
        }
    }
}

#Preview {
    UIStoryboard(name: "Home", bundle: nil).instantiateInitialViewController() as! HomeViewController
}
