//
//  Settings.swift
//  WarmUp
//
//  Created by 서정원 on 7/20/24.
//

import SwiftUI

struct SettingsInfo: Hashable {
    let title: String
    let systemName: String
    let backgroundColor: Color
    let foregroundColor: Color = .white
}

struct Settings: View {
    
    let data: [[SettingsInfo]] = [[SettingsInfo(title: "스크린타임", systemName: "hourglass", backgroundColor: .purple)],
                                  [SettingsInfo(title: "일반", systemName: "gear", backgroundColor: .blue),SettingsInfo(title: "스크린타임", systemName: "hourglass", backgroundColor: .purple)]]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(data, id: \.self) { section in
                    Section {
                        ForEach(section, id: \.self) { item in
                            Label(
                                title: { Text("스크린타임")  },
                                icon: { Image(systemName: item.systemName).resizable()
                                        .scaledToFit()
                                        .padding(.all, 7)
                                        .background(item.backgroundColor)
                                        .foregroundColor(item.foregroundColor)
                                        .cornerRadius(6) }
                            )
                        }
                    }
                }
//                
//                
//                Section {       //Section 을 써주면 동떨어지는 것처럼 됨
//                    Label(
//                        title: { Text("스크린타임") },
//                        icon: { Image(systemName: "hourglass")
//                                
//                            
//                        }
//                        
//                    )
//                }
//                
//                
//                
//                Label(
//                    title: { Text("일반") },
//                    icon: { Image(systemName: "gear")
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.all, 7)
//                            .background(.purple)
//                            .foregroundColor(.white)
//                            .cornerRadius(6)
//                    }
//                )
//                
//                Label(
//                    title: { Text("스크린타임") },
//                    icon: { Image(systemName: "hourglass")
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.all, 7)
//                            .background(.purple)
//                            .foregroundColor(.white)
//                        .cornerRadius(6)}
//                )
//                
//                Label(
//                    title: { Text("스크린타임") },
//                    icon: { Image(systemName: "hourglass")
//                            .resizable()
//                            .scaledToFit()
//                            .padding(.all, 7)
//                            .background(.purple)
//                            .foregroundColor(.white)
//                            .cornerRadius(6)
//                    }
//                )
            }
            .navigationTitle("설정")
        }
    }
}

#Preview {
    Settings()
}
