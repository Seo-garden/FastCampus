//
//  Modal.swift
//  WarmUp
//
//  Created by 서정원 on 7/20/24.
//

import SwiftUI

struct Modal: View {
    
    @State var showModal: Bool = false
    var body: some View {
        VStack {
            Text("메인페이지입니다.")
            Button {
                showModal = true
            } label: {
                Text("Modal 화면 전환")
            }
        }
        .sheet(isPresented: $showModal) {
            Detail(isPresented: $showModal)
        }
    }
}

#Preview {
    Modal()
}
