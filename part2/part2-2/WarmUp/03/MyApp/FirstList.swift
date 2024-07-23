//
//  FirstList.swift
//  WarmUp
//
//  Created by 서정원 on 7/21/24.
//

import SwiftUI

struct FirstList: View {
    var body: some View {
        NavigationStack {
            
            List {
                NavigationLink {
                    Text("첫번째 하위페이지 입니다.")
                } label : {
                    Text("1번째 하위페이지")
                }
                
                NavigationLink {
                    Text("2번째 하위페이지 입니다.")
                } label : {
                    Text("2번째 하위페이지")
                }
                
                NavigationLink {
                    Text("3번째 하위페이지 입니다.")
                } label : {
                    Text("3번째 하위페이지")
                }
                
                NavigationLink {
                    Text("4번째 하위페이지 입니다.")
                } label : {
                    Text("4번째 하위페이지")
                }
            }
            .navigationTitle("리스트")
        }
    }
}

#Preview {
    FirstList()
}
