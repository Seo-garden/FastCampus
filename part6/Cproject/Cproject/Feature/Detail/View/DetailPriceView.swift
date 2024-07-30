//
//  DetailPriceView.swift
//  Cproject
//
//  Created by 서정원 on 7/30/24.
//

import SwiftUI

final class DetailPriceViewModel: ObservableObject {
    var discountRate: String
    var originPrice: String
    var currentPrice: String
    var shoppingType: String
    
    init(discountRate: String, originPrice: String, currentPrice: String, shoppingType: String) {
        self.discountRate = discountRate
        self.originPrice = originPrice
        self.currentPrice = currentPrice
        self.shoppingType = shoppingType
    }
}

struct DetailPriceView: View {
    @ObservedObject var viewModel: DetailPriceViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 21, content: {
            VStack(alignment: .leading, spacing: 6, content: {
                HStack(spacing: 0, content: {
                    Text(viewModel.discountRate)
                        .font(CPFont.SwiftUI.b14)
                        .foregroundStyle(CPColor.SwiftUI.icon)
                        
                    Text(viewModel.originPrice)
                        .font(CPFont.SwiftUI.b16)
                        .strikethrough()
                        .foregroundStyle(CPColor.SwiftUI.gray5)
                })
                Text(viewModel.currentPrice)
                    .font(CPFont.SwiftUI.b20)
                    .foregroundStyle(CPColor.SwiftUI.keyColorRed)
            })
            Text(viewModel.shoppingType)
                .font(CPFont.SwiftUI.r12)
                .foregroundStyle(CPColor.SwiftUI.icon)
        })
    }
}

#Preview {
    DetailPriceView(viewModel: DetailPriceViewModel(discountRate: "53%", originPrice: "300,000원", currentPrice: "139,000원", shoppingType: "무료배송"))
}
