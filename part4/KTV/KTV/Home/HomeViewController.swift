//
//  HomeViewController.swift
//  KTV
//
//  Created by 서정원 on 7/22/24.
//

import UIKit

class HomeViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
    }

    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: HomeVideoCell.identifier, bundle: nil), forCellReuseIdentifier: HomeVideoCell.identifier)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        HomeSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = HomeSection(rawValue: section) else { return 0 }
        
        switch section {
        case .video:
            return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = HomeSection(rawValue: indexPath.row) else { return UITableViewCell() }
        
        switch section {
        case .video:
            return tableView.dequeueReusableCell(withIdentifier: HomeVideoCell.identifier, for: indexPath)
        }
    }
}
