//
//  DetailRateView.swift
//  Cproject
//
//  Created by 서정원 on 7/30/24.
//

import SwiftUI

final class DetailRateViewModel: ObservableObject {
    init(rate: Int) {
        self.rate = rate
    }
    @Published var rate: Int
}

struct DetailRateView: View {
    @ObservedObject var viewModel: DetailRateViewModel
    var body: some View {
        HStack(spacing: 4, content: {
            ForEach(0..<viewModel.rate, id: \.self) { _ in
                starImage
                    .foregroundStyle(CPColor.SwiftUI.yellow)
            }
            ForEach(0..<(5 - viewModel.rate), id: \.self) { _ in
                starImage
                    .foregroundStyle(CPColor.SwiftUI.gray2)
            }
        })
    }
    
    var starImage: some View {
        Image(systemName: "star.fill")
            .resizable()
            .frame(width: 16, height: 16)
    }
}

#Preview {
    DetailRateView(viewModel: DetailRateViewModel(rate: 4))
}
