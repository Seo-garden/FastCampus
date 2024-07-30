//
//  DetailMoreView.swift
//  Cproject
//
//  Created by 서정원 on 7/30/24.
//

import SwiftUI

final class DetailMoreViewModel: ObservableObject {
    
}

struct DetailMoreView: View {
    @ObservedObject var viewModel: DetailMoreViewModel
    var onMoreTapped: () -> Void
    var body: some View {
        Button {
            onMoreTapped()
        } label: {
            HStack(alignment: .center, spacing: 10, content: {
                Text("상품정보 더보기")
                    .font(CPFont.SwiftUI.b17)
                    .foregroundStyle(CPColor.SwiftUI.keyColorBlue)
                Image(.down)
                    .foregroundStyle(CPColor.SwiftUI.icon)
            })
            .frame(maxWidth: .infinity, minHeight: 40, maxHeight: 40)
            .border(CPColor.SwiftUI.keyColorBlue, width: 1)
        }

        
    }
}

#Preview {
    DetailMoreView(viewModel: DetailMoreViewModel(), onMoreTapped: {})
}
