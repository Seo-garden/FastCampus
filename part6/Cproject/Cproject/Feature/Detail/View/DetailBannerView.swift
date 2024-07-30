//
//  DetailBannerView.swift
//  Cproject
//
//  Created by 서정원 on 7/30/24.
//

import SwiftUI
import Kingfisher

final class DetailBannerViewModel: ObservableObject {
    init(imageUrls: [String]) {
        self.imageUrls = imageUrls
    }
    
    @Published var imageUrls: [String]
    
}

struct DetailBannerView: View {
    @ObservedObject var viewModel: DetailBannerViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0, content: {
                ForEach(viewModel.imageUrls, id: \.self) { imageUrl in
                    KFImage(URL(string: viewModel.imageUrls.first!))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()      //영역이 넘어가면 잘림
                }
            })
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)   //1:1비율
        .scrollTargetBehavior(.paging)
        .scrollIndicators(.never)       //하단 배너에 있던 막대 같은것이 사라짐
    }
}

#Preview {
    DetailBannerView(viewModel: DetailBannerViewModel(imageUrls: ["https://picsum.photos/id/1/500/500",
        "https://picsum.photos/id/2/500/500",
        "https://picsum.photos/id/3/500/500",
        "https://picsum.photos/id/4/500/500"]))
}
