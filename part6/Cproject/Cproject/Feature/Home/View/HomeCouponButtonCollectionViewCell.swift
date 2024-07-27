//
//  HomeCouponButtonCollectionViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/27/24.
//
import Combine
import UIKit

struct HomeCouponButtonCollectionViewCellViewModel: Hashable {
    enum CouponState {
        case enable
        case disable
    }
    var state: CouponState
}

final class HomeCouponButtonCollectionViewCell: UICollectionViewCell {      //final 은 더 이상 상속을 하지 않을 클래스에 붙혀준다.
    static let reusableId: String = "HomeCouponButtonCollectionViewCell"
    private weak var didTapCouponDownload: PassthroughSubject<Void, Never>?
    
    @IBOutlet weak var couponButton: UIButton! {
        didSet {
            couponButton.setImage(CPImages.buttonActivate, for: .normal)
            couponButton.setImage(CPImages.buttonComplete, for: .disabled)
        }
    }

    
    
    func setViewModel(_ viewModel: HomeCouponButtonCollectionViewCellViewModel, _ didTapCouponDownload: PassthroughSubject<Void, Never>?) {
        self.didTapCouponDownload = didTapCouponDownload
        couponButton.isEnabled = switch viewModel.state {
        case .enable:
            true
        case .disable:
            false
        }
    }
    
    @IBAction private func didTapCouponButton(_ sender: UIButton) {
        didTapCouponDownload?.send()
    }
}

extension HomeCouponButtonCollectionViewCell {
    static func couponButtonItemLayout() -> NSCollectionLayoutSection {
        let itemSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))       //그룹의 사이즈를 그대로 가져감
        let item: NSCollectionLayoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize: NSCollectionLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(37))
        let group: NSCollectionLayoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section: NSCollectionLayoutSection = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 28, leading: 22, bottom: 0, trailing: 22)
        
        return section
    }
}
