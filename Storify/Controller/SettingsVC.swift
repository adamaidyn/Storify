//
//  SettingsVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/6/22.
//

import UIKit
import RevenueCat

class SettingsVC: UIViewController {
    
    // MARK: - UI Elements and variables
    private let settingsTableView: UITableView = {
        let view = UITableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped)
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var planOptionsVC = PlanOptionsVC()
    
    var storifyModel = StorifyModel()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBarButtons()
        title = "Settings"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(settingsTableView)
    
        overrideUserInterfaceStyle = .dark
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        settingsTableView.backgroundColor = K.UnifiedColors.darkGray
        settingsTableView.frame = view.bounds
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        settingsTableView.isScrollEnabled = false
        
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return storifyModel.settingsNames1.count
        case 1:
            return storifyModel.settingsNames2.count
        case 2:
            return storifyModel.settingsNames3.count
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
            content.text = storifyModel.settingsNames1[indexPath.row]
            content.image = storifyModel.imageSet1[indexPath.row]
        case 1:
            content.text = storifyModel.settingsNames2[indexPath.row]
            content.image = storifyModel.imageSet2[indexPath.row]
        case 2:
            content.text = storifyModel.settingsNames3[indexPath.row]
            content.image = storifyModel.imageSet3[indexPath.row]
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
                openWebPage(webpageUrl: K.VariablesIDs.reviewAppLink)
            case 1:
                planOptionsVC.restorePurchases()
            case 2:
                let rootVC = PlanOptionsVC()
                let navVC = UINavigationController(rootViewController: rootVC)
                navVC.modalPresentationStyle = .automatic
                rootVC.ifComingFromHome = false
                present(navVC, animated: true)
            default:
                print("error")
            }
        case 1:
            switch indexPath.row {
            case 0:
                openWebPage(webpageUrl: K.VariablesIDs.privacyWebPage)
            case 1:
                openWebPage(webpageUrl: K.VariablesIDs.termsWebPage)
            case 2:
                openWebPage(webpageUrl: K.VariablesIDs.supportWebPage)
            default:
                print("error")
            }
        case 2:
            switch indexPath.row {
            case 0:
                print("There's nothing, yet...")
            default:
                print("error")
            }
        default:
            print("error")
        }
    }
    
    private func openWebPage(webpageUrl: String) {
        guard let url = URL(string: webpageUrl) else { return }
        UIApplication.shared.open(url)
    }
}
