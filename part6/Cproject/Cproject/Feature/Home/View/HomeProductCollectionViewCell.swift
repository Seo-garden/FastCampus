//
//  HomeProductCollectionViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit
import Kingfisher

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageUrlString: String
    let title: String
    let reasonDiscountString: String
    let originalPrice: String
    let disCountPrice: String
}

final class HomeProductCollectionViewCell: UICollectionViewCell {
    static let reusableId: String = "HomeProductCollectionViewCell"
    @IBOutlet private weak var productItemImageView: UIImageView! {
        didSet { 
            productItemImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet private weak var productTitleLabel: UILabel!
    @IBOutlet private weak var productreasonDiscountLabel: UILabel!
    @IBOutlet private weak var originalPriceLabel: UILabel!
    @IBOutlet private weak var discountPriceLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
        productItemImageView.kf.setImage(with: URL(string: viewModel.imageUrlString))
        productTitleLabel.text = viewModel.title
        productreasonDiscountLabel.text = viewModel.reasonDiscountString
        originalPriceLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPrice, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])       //Style: 중간에 줄 긋기
        discountPriceLabel.text = viewModel.disCountPrice
    }
}

extension HomeProductCollectionViewCell {
    static func horizontalProductItemLayout() -> NSCollectionLayoutSection {        //인스턴스 생성 없이 클래스 자체에서 호출하기 위함으로 반복적으로 사용되는 메서드를 간편하게 호출해서 사용
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))       //그룹의 사이즈를 그대로 가져감
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .estimated(224))     //예상치
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous       //섹션 내의 아이템을 세로스크롤 방식에서 가로로 스크롤 = .부드럽고 연속적으로
        section.contentInsets = .init(top: 20, leading: 33, bottom: 0, trailing: 33)
        section.interGroupSpacing = 10      //그룹별 여백 10
        
        return section
    }
    
    static func verticalProductItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 2), heightDimension: .estimated(277))       //그룹의 사이즈를 그대로 가져감
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(277))     //예상치
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none     //수평 스크롤 비활성화
        section.contentInsets = .init(top: 20, leading: 19 - 2.5, bottom: 0, trailing: 19 - 2.5)
        section.interGroupSpacing = 10      //그룹별 여백 10
        
        return section
    }
}
