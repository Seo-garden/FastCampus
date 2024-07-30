//
//  DetailPurchaseView.swift
//  Cproject
//
//  Created by 서정원 on 7/30/24.
//

import SwiftUI

final class DetailPurchaseViewModel: ObservableObject {
    @Published var isFavorite: Bool
    
    init(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}

struct DetailPurchaseView: View {
    @ObservedObject var viewModel: DetailPurchaseViewModel
    
    var onFavoriteTapped: () -> Void
    var onPurchaseTapped: () -> Void
    
    var body: some View {
        HStack(spacing: 30, content: {
            Button(action: onFavoriteTapped, label: {
                viewModel.isFavorite ? Image(.favoriteOn) : Image(.favoriteOff)
            })
    
            Button(action: onPurchaseTapped, label: {
                Text("구매하기")
                    .font(CPFont.SwiftUI.m16)
                    .foregroundStyle(CPColor.SwiftUI.wh)
            })
            .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .background(CPColor.SwiftUI.keyColorBlue)
            .clipShape(RoundedRectangle(cornerRadius: 5))
        })
        .padding(.top, 10)
        .padding(.horizontal, 25)
    }
}

#Preview {
    DetailPurchaseView(viewModel: DetailPurchaseViewModel(isFavorite: false), onFavoriteTapped: {}, onPurchaseTapped: {})
}
