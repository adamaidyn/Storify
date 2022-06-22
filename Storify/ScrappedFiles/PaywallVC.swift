//
//  PayWallVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/9/22.
//

import UIKit

class PaywallVC: UIViewController {
    
    private let subsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let subscribeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .selectPackage()
        return button
    }()
    
    private let paymentOptions = [
        "3.99 Per 1 Month",
        "19.99 Per 6 Month",
        "32.99 Per 12 Month"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        subsTableView.delegate = self
        subsTableView.dataSource = self
        subsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "PayWallCell")
        subsTableView.isScrollEnabled = false
        
        subscribeButton.isSelected = true
        
        setConstraints()
    }
    

    func setConstraints() {
        view.addSubview(subsTableView)
        view.addSubview(subscribeButton)
        
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
        contraints.append(subsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        contraints.append(subsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        contraints.append(subsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(subsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        contraints.append(subsTableView.heightAnchor.constraint(equalToConstant: 200))
        
        contraints.append(subscribeButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(subscribeButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(subscribeButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20))

        
        NSLayoutConstraint.activate(contraints)
    }

}
extension PaywallVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = subsTableView.dequeueReusableCell(withIdentifier: "PayWallCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.text = paymentOptions[indexPath.row]
        
        cell.contentConfiguration = content
        return cell
    }
    
}

extension UIButton.Configuration {
    static func selectPackage() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.title = "Subscribe"
        config.subtitle = "After trial payment"
        config.titleAlignment = .center
        config.baseBackgroundColor = .systemGreen
//        config.baseForegroundColor = UIColor(named: "ColorTS")
        return config
    }
}
