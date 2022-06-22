//
//  SettingsVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/6/22.
//

import UIKit
import StoreKit

class SettingsVC: UIViewController {
    
    // MARK: - UI Elements and variables
    private let settingsTableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let settingsNames1 = [
        "Rate App",
        "Restore Purchases",
        "Subscriptions"
    ]
    
    let settingsNames2 = [
        "Privacy policy",
        "Terms & Conditions"
    ]
    
    let imageSet1 = [
        UIImage(systemName: "star"),
        UIImage(systemName: "dollarsign.circle"),
        UIImage(systemName: "cart.badge.plus")
    ]
    
    let imageSet2 = [
        UIImage(systemName: "person.fill.viewfinder"),
        UIImage(systemName: "doc.text")
    ]
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBarButtons()
        title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsTableView)
        
        settingsTableView.backgroundColor = K.UnifiedColors.darkGray
        settingsTableView.frame = view.bounds
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        settingsTableView.isScrollEnabled = false
        
        overrideUserInterfaceStyle = .dark
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }

}
// MARK: - Navigation bar configuration
extension SettingsVC {
    private func configureNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(dismissSelf)
        )
        navigationItem.rightBarButtonItem?.tintColor = K.UnifiedColors.greenColor
    }
}

// MARK: - TableView Delegate & Datasource
extension SettingsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return settingsNames1.count
        case 1:
            return settingsNames2.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        cell.backgroundColor = K.UnifiedColors.lightGray
        
        switch indexPath.section {
        case 0:
            content.text = settingsNames1[indexPath.row]
            content.image = imageSet1[indexPath.row]
        case 1:
            content.text = settingsNames2[indexPath.row]
            content.image = imageSet2[indexPath.row]
        default:
            content.text = "Error"
        }
        
        content.imageProperties.tintColor = K.UnifiedColors.greenColor
        
        cell.contentConfiguration = content
        return cell
    }
    
    // Delegate did select
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                openWebPage(webpageUrl: "https://apps.apple.com/app/storify-zip-photos-videos/id1628718718")
            case 1:
                SKPaymentQueue.default().restoreCompletedTransactions() // Restores purchases
            case 2:
                print(indexPath.row)
            default:
                print("error")
            }
        case 1:
            switch indexPath.row {
            case 0:
                openWebPage(webpageUrl: "https://www.cherrydevs.com/privacy")
            case 1:
                openWebPage(webpageUrl: "https://www.cherrydevs.com/terms-conditions")
            default:
                print("error")
            }
        default:
            print("errorR")
        }
    }
    
    private func openWebPage(webpageUrl: String) {
        guard let url = URL(string: webpageUrl) else { return }
        UIApplication.shared.open(url)
    }
}
