//
//  OptionRootView.swift
//  Cproject
//
//  Created by 서정원 on 7/31/24.
//

import SwiftUI

struct OptionRootView: View {
    @ObservedObject var viewModel: OptionViewModel
    var body: some View {
        Text("옵션 화면")
    }
}

#Preview {
    OptionRootView(viewModel: OptionViewModel())
}
