//
//  PurchaseViewController.swift
//  Cproject
//
//  Created by 서정원 on 7/31/24.
//

import Combine
import UIKit
import SwiftUI

final class PurchaseViewController: UIViewController {
    private var cancellables : Set<AnyCancellable> = []
    private var viewModel: PurchaseViewModel = PurchaseViewModel()
    private var rootView: PurchaseRootView = PurchaseRootView()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        bindViewModel()
        viewModel.process(.loadData)
    }
    
    private func bindViewModel() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let viewModels = self?.viewModel.state.purchaseItems else { return }
                self?.rootView.setPurchaseItem(viewModels)
            }
            .store(in: &cancellables)
    }
}

#Preview {
    PurchaseViewController()
}
