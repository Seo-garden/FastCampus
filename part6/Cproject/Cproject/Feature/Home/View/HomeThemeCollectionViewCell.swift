//
//  HomeThemeCollectionViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/27/24.
//

import Kingfisher
import UIKit

struct HomeThemeCollectionViewCellViewModel: Hashable {
    let themeImageUrl: String
}

final class HomeThemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var themeImageView: UIImageView!
    static let reusableId: String = "HomeThemeCollectionViewCell"
    
    func setViewModel(_ viewModel: HomeThemeCollectionViewCellViewModel) {
        themeImageView.kf.setImage(with: URL(string: viewModel.themeImageUrl))
    }
}

extension HomeThemeCollectionViewCell {
    static func themeLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupFractionWidth: CGFloat = 0.7       //테마관 아래 사진크기
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupFractionWidth), heightDimension: .fractionalHeight((142 / 286) * groupFractionWidth))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 35, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(65))      //heightDimension은 테마관 글자 높이
        let header: NSCollectionLayoutBoundarySupplementaryItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
}
