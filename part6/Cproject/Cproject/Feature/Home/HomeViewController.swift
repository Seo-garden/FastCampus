//
//  HomeViewController.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit


class HomeViewController: UIViewController {
    enum Section: Int {
        case banner
        case horizontalProductItem
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?  //dataSource 값을 만들때는 컬렉션뷰가 필요한데, collectionView 가 생성된 후에 사용할 수 있어서 viewDidLoad() 이후에 값을 할당한다.
    
    private var compositinalLayout: UICollectionViewCompositionalLayout = {
        UICollectionViewCompositionalLayout { section, _ in
            switch Section(rawValue: section) {
            case .banner:
                let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))       //그룹의 사이즈를 그대로 가져감
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(165 / 393))
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging      //기존엔 아래로 화면 3개가 나열되어 있었는데, 제스처를 통해서
                
                return section
                
            case.horizontalProductItem:
                let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))       //그룹의 사이즈를 그대로 가져감
                let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))     //예상치
                let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.contentInsets = .init(top: 20, leading: 33, bottom: 0, trailing: 33)
                
                return section
                
            case.none:
                return nil
            }
        }
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, viewModel in
            
            switch Section(rawValue: indexPath.section) {
            case .banner:
                guard let viewModel = viewModel as? HomeBannerCollectionViewCellViewModel, let cell: HomeBannerCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCollectionViewCell", for: indexPath) as? HomeBannerCollectionViewCell else { return .init()}
                
                cell.setViewModel(viewModel)
                
                return cell
                
            case .horizontalProductItem:
                guard let viewModel = viewModel as? HomeProductCollectionViewCellViewModel, let cell: HomeProductCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeProductCollectionViewCell", for: indexPath) as? HomeProductCollectionViewCell else { return .init() }

                cell.setViewModel(viewModel)
                
                return cell
                
            case .none:
                return .init()
            }
            
            
        })
        
        var snapshot: NSDiffableDataSourceSnapshot<Section, AnyHashable> = NSDiffableDataSourceSnapshot<Section, AnyHashable>()
        snapshot.appendSections([.banner])
        
        snapshot.appendItems([
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide1)),
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide2)),
            HomeBannerCollectionViewCellViewModel(bannerImage: UIImage(resource: .slide3))], toSection: .banner)
        
        snapshot.appendSections([.horizontalProductItem])
        snapshot.appendItems([
            HomeProductCollectionViewCellViewModel(imageUrlString: "12", title: "playStation1", reasonDiscountString: "쿠폰 할인", originalPrice: "10000", disCountPrice: "8000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "12", title: "playStation2", reasonDiscountString: "쿠폰 할인", originalPrice: "20000", disCountPrice: "8000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "12", title: "playStation3", reasonDiscountString: "쿠폰 할인", originalPrice: "30000", disCountPrice: "10000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "12", title: "playStation4", reasonDiscountString: "쿠폰 할인", originalPrice: "40000", disCountPrice: "300000"),
            HomeProductCollectionViewCellViewModel(imageUrlString: "12", title: "playStation5", reasonDiscountString: "쿠폰 할인", originalPrice: "50000", disCountPrice: "40000")], toSection: .horizontalProductItem)
        dataSource?.apply(snapshot)
        
        collectionView.collectionViewLayout = compositinalLayout
    }
}
