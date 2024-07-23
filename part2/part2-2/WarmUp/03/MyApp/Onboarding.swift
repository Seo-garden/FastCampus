//
//  Onboarding1.swift
//  WarmUp
//
//  Created by 서정원 on 7/21/24.
//

import SwiftUI

struct Onboarding: View {
    
    let onboardingTitle: String
    let backgroundColor: Color

    
    var body: some View {
        ZStack {
            backgroundColor.ignoresSafeArea()
            Text(onboardingTitle)
        }
    }
}

#Preview {
    Onboarding(onboardingTitle: "온보딩테스트", backgroundColor: .blue)
}
