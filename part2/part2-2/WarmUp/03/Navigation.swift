//
//  Navigation.swift
//  WarmUp
//
//  Created by 서정원 on 7/20/24.
//

import SwiftUI

struct info: Hashable {
    let title: String
    let discription: String
}


struct Navigation: View {
    
    @State var info1 = [info(title: "asd", discription: "asd"), info(title: "asd1", discription: "asd1")]
    
    @State var showModal: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(info1, id: \.self) { indexPath in
                    NavigationLink {
                        Text(indexPath.discription)
                    } label: {
                        Text(indexPath.title)
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        showModal = true
                    } label: {
                        Text("추가")
                    }
                    
                }
            }
            .sheet(isPresented: $showModal, content: {
                Text("아이템 추가 안내 페이지 입니다.")
            })
            .navigationTitle("네비게이션")
        }
    }
}

#Preview {
    Navigation()
}
