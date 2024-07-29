//
//  FavoriteItemTableViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/29/24.
//

import Kingfisher
import UIKit

struct FavoriteItemTableViewCellViewModel: Hashable {
    let imageUrl: String
    let productName: String
    var productPrices: String
}

final class FavoriteItemTableViewCell: UITableViewCell {
    @IBOutlet weak var productItemImageView: UIImageView!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productPurchaseButton: PurchaseButton!
    
    static let reusableId: String = "FavoriteItemTableViewCell"

    func setViewModel(_ viewModel: FavoriteItemTableViewCellViewModel) {
        productItemImageView.kf.setImage(with: URL(string:viewModel.imageUrl))
        productTitleLabel.text = viewModel.productName
        productPriceLabel.text = viewModel.productPrices
    }
}
