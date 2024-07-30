//
//  Product.swift
//  Cproject
//
//  Created by 서정원 on 7/29/24.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
