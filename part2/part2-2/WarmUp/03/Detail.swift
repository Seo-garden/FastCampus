//
//  Detail.swift
//  WarmUp
//
//  Created by 서정원 on 7/20/24.
//

import SwiftUI

struct Detail: View {
    
    @Binding var isPresented: Bool
    var body: some View {
        Text("모달페이지입니다.")
        Button {
            isPresented = false
        } label: {
            Text("닫기")
        }

    }
}

#Preview {
    Detail(isPresented: .constant(true))
}
