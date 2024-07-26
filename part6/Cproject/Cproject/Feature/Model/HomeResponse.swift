//
//  HomeResponse.swift
//  Cproject
//
//  Created by 서정원 on 7/25/24.
//

import Foundation
import UIKit

struct HomeResponse: Decodable {
    let banners: [Banner]
    let horizontalProducts: [Product]
    let verticalProducts: [Product]
//    let thems: [Banner]
}

struct Banner: Decodable {
    let id: Int
    let imageUrl: String
}

struct Product: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
    let discount: String
    let originalPrice: Int
    let discountPrice: Int
}
