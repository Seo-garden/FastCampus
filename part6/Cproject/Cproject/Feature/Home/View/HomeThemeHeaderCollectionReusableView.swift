//
//  HomeThemeCollectionReusableView.swift
//  Cproject
//
//  Created by 서정원 on 7/27/24.
//

import UIKit

struct HomeThemeHeaderCollectionReusableViewModel {
    var headerText: String
}

final class HomeThemeHeaderCollectionReusableView: UICollectionReusableView {
    static let reusableId: String = "HomeThemeHeaderCollectionReusableView"
    @IBOutlet weak var themeHeaderLabel: UILabel!
    
    
    func setViewModel(_ viewModel: HomeThemeHeaderCollectionReusableViewModel) {
        themeHeaderLabel.text = viewModel.headerText
    }
}
