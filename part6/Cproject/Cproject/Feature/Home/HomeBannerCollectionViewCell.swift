//
//  HomeBannerCollectionViewCell.swift
//  Cproject
//
//  Created by 서정원 on 7/24/24.
//

import UIKit

struct HomeBannerCollectionViewCellViewModel: Hashable {
    let bannerImage: UIImage
}

class HomeBannerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    func setViewModel(_ viewModel : HomeBannerCollectionViewCellViewModel) {
        imageView.image = viewModel.bannerImage
    }
}
