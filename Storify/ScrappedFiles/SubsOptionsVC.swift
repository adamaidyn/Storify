//
//  SubsOptionsVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/13/22.
//

import UIKit

class SubsOptionsVC: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(
            CollectionTableViewCell.self ,
            forCellReuseIdentifier: CollectionTableViewCell.identifier
        )
        return tableView
    }()
    
    private let viewModels: [CollectionViewCellViewModel] = [
        CollectionViewCellViewModel(viewModels: [
            TileCollectionViewCellViewModel(name: "Apple", backgroundColor: .systemIndigo, images: UIImage(systemName: "dollarsign.circle")!),
            TileCollectionViewCellViewModel(name: "Google", backgroundColor: .systemRed, images: UIImage(systemName: "dollarsign.circle")!),
            TileCollectionViewCellViewModel(name: "Samsung", backgroundColor: .systemGreen, images: UIImage(systemName: "dollarsign.circle")!),
            TileCollectionViewCellViewModel(name: "Nvidia", backgroundColor: .systemYellow, images: UIImage(systemName: "dollarsign.circle")!),
            TileCollectionViewCellViewModel(name: "Intel", backgroundColor: .systemPink, images: UIImage(systemName: "dollarsign.circle")!),
            TileCollectionViewCellViewModel(name: "Twitter", backgroundColor: .systemCyan, images: UIImage(systemName: "dollarsign.circle")!)
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        tableView.frame = CGRect(x: 10, y: 20, width: view.frame.width, height: view.frame.height / 2.5)
    }
    
    

}
extension SubsOptionsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CollectionTableViewCell.identifier,
            for: indexPath
        ) as? CollectionTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.width / 2
    }
}
