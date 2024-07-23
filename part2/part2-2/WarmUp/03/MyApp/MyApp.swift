//
//  MyApp.swift
//  WarmUp
//
//  Created by 서정원 on 7/21/24.
//

import SwiftUI

struct MyApp: View {
    
    @State var showModal: Bool = false
    
    var body: some View {
        TabView {
            FirstList()
                .tabItem {
                    Label("first", systemImage: "tray.and.arrow.down.fill")
                }
            Text("두번째 페이지")
                .tabItem {
                    Label("second", systemImage: "tray.and.arrow.down.fill")
                }
            
            Text("3번째 페이지")
                .tabItem {
                    Label("third", systemImage: "tray.and.arrow.down.fill")
                }
            
            Text("4번째 페이지")
                .tabItem {
                    Label("fourth", systemImage: "tray.and.arrow.down.fill")
                }
        }
        .sheet(isPresented: $showModal, content: {
            TabView {
                Onboarding(onboardingTitle: "온보딩 1", backgroundColor: .gray)
                
                ZStack {
                    Color.green.ignoresSafeArea()
                    Text("온보딩 2")
                }
                
                ZStack {
                    Color.gray.ignoresSafeArea()
                    VStack {
                        Text("온보딩 3")
                        Button {
                            showModal = false
                        } label: {
                            Text("Start")
                        }

                    }
                }
            }
            .tabViewStyle(.page)
        })
        .onAppear() {       //호출되자마자 바로 보이는 것
            showModal = true
        }
    }
}

#Preview {
    MyApp()
}
