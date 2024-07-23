//
//  TabDetail.swift
//  WarmUp
//
//  Created by 서정원 on 7/21/24.
//

import SwiftUI

struct TabDetail: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            VStack {
                Text("This is Detail")
                
                Button {
                    
                } label: {
                    Text("continue")
                        .padding()
                        .background(.green)
                        .cornerRadius(10)
                }

            }
            
        }
        
    }
}

#Preview {
    TabDetail()
}
