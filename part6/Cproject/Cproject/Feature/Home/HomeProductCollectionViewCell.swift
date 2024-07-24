//
//  HomeProductCollectionViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit

struct HomeProductCollectionViewCellViewModel: Hashable {
    let imageUrlString: String
    let title: String
    let reasonDiscountString: String
    let originalPrice: String
    let disCountPrice: String
}

class HomeProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productItemImageView: UIImageView! {
        didSet {
            productItemImageView.layer.cornerRadius = 5
        }
    }
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productreasonDiscountLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    func setViewModel(_ viewModel: HomeProductCollectionViewCellViewModel) {
//        productItemImageView.image = viewModel.imageUrlString
        productTitleLabel.text = viewModel.title
        productreasonDiscountLabel.text = viewModel.reasonDiscountString
        originalPriceLabel.attributedText = NSMutableAttributedString(string: viewModel.originalPrice, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])       //중간에 줄 긋기
        discountPriceLabel.text = viewModel.disCountPrice
    }
}
