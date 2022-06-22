//
//  Paywall2VC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/9/22.
//

import UIKit

class Paywall2VC: UIViewController {
    
    private let package1Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let package2Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let package3Button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let packageImageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .regular, scale: .default)
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.image = UIImage(systemName: "dollarsign.circle.fill", withConfiguration: config)
        imageView.image = UIImage(named: "ImageTest")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .systemGreen
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unlimited Access"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get access to all features"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let premiumDesriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "✨ Unlimited archives.\n🚀 Export anywhere.\n❌ No ads.\n😇 Big support for future updates."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let choosePlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "CHOOSE A PLAN"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let planTermsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cancel subscription up to 24h before trial ends. Itunes will only charge you after 3 days."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        configureNavBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setConstraints()
        
        package1Button.configuration = selectPackage(title: "1", subtitle: "3.99 Month", buttonStyle: .tinted(), color: .systemGreen)
        package2Button.configuration = selectPackage(title: "6", subtitle: "19.99 Month", buttonStyle: .tinted(), color: .systemGreen)
        package3Button.configuration = selectPackage(title: "12", subtitle: "29.99 Month", buttonStyle: .tinted(), color: .systemGreen)
        
        package1Button.addTarget(self, action: #selector(buttonSender), for: .touchUpInside)
        package2Button.addTarget(self, action: #selector(buttonSender), for: .touchUpInside)
        package3Button.addTarget(self, action: #selector(buttonSender), for: .touchUpInside)
        
        package1Button.isSelected = false
        package2Button.isSelected = false
        package3Button.isSelected = true
        
        continueButton.configuration = selectPackage(
            title: "Try 3 days free and subscribe",
            subtitle: "",
            buttonStyle: .filled(),
            color: .systemBlue)
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc func buttonSender(sender: UIButton) {
        
        
        package1Button.isSelected = false
        package2Button.isSelected = false
        package3Button.isSelected = false
        
        sender.isSelected = true
        
        switch sender {
        case package1Button:
            print("Plan 1")
        case package2Button:
            print("Plan 2")
        case package3Button:
            print("Plant 3")
        default:
            print("Error")
        }

    }
    
    @objc private func continueButtonTapped() {
        if package1Button.isSelected == true {
            print("Plan 1 month is selected")
        } else if package2Button.isSelected == true {
            print("Plan 6 month is selected")
        } else if package3Button.isSelected == true {
            print("Plan 12 month is selected")
        }
    }
    
    @objc private func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
    
    func setConstraints() {
        
        view.addSubview(packageImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(premiumDesriptionLabel)
        view.addSubview(choosePlanLabel)
        view.addSubview(package1Button)
        view.addSubview(package2Button)
        view.addSubview(package3Button)
        view.addSubview(continueButton)
        view.addSubview(planTermsLabel)
        
        
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
        contraints.append(packageImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        contraints.append(packageImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        contraints.append(packageImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(packageImageView.topAnchor.constraint(equalTo: view.topAnchor))
        contraints.append(packageImageView.heightAnchor.constraint(equalToConstant: 150))
        
        contraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(titleLabel.topAnchor.constraint(equalTo: packageImageView.bottomAnchor, constant: 20))
        
        contraints.append(subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor))

        contraints.append(premiumDesriptionLabel.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(premiumDesriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20))
        
        contraints.append(choosePlanLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(choosePlanLabel.topAnchor.constraint(equalTo: premiumDesriptionLabel.bottomAnchor, constant: 20))
        
        contraints.append(package1Button.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(package1Button.topAnchor.constraint(equalTo: choosePlanLabel.bottomAnchor, constant: 10))
        contraints.append(package1Button.heightAnchor.constraint(equalToConstant: 120))
        contraints.append(package1Button.widthAnchor.constraint(equalToConstant: 90))
        
//        contraints.append(package2Button.leadingAnchor.constraint(equalTo: package1Button.trailingAnchor, con1tant: 20))
        contraints.append(package2Button.topAnchor.constraint(equalTo: choosePlanLabel.bottomAnchor, constant: 10))
        contraints.append(package2Button.heightAnchor.constraint(equalToConstant: 120))
        contraints.append(package2Button.widthAnchor.constraint(equalToConstant: 90))
        contraints.append(package2Button.centerXAnchor.constraint(equalTo: layout.centerXAnchor))
        
        contraints.append(package3Button.topAnchor.constraint(equalTo: choosePlanLabel.bottomAnchor, constant: 10))
        contraints.append(package3Button.heightAnchor.constraint(equalToConstant: 120))
        contraints.append(package3Button.widthAnchor.constraint(equalToConstant: 90))
        contraints.append(package3Button.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        
        contraints.append(continueButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(continueButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(continueButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor))
        contraints.append(continueButton.heightAnchor.constraint(equalToConstant: 50))
        
        contraints.append(planTermsLabel.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(planTermsLabel.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(planTermsLabel.topAnchor.constraint(equalTo: package1Button.bottomAnchor, constant: 5))
        contraints.append(planTermsLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -5))
        
        NSLayoutConstraint.activate(contraints)
    }

    private func selectPackage(title: String, subtitle: String, buttonStyle: UIButton.Configuration, color: UIColor) -> UIButton.Configuration {
        var config: UIButton.Configuration = buttonStyle
        config.title = title
        config.subtitle = subtitle
        config.titleAlignment = .center
        config.baseBackgroundColor = color
        config.titlePadding = 10
        config.cornerStyle = .medium
        config.baseForegroundColor = UIColor(named: "ColorTS")
        return config
    }
    
    
}
extension Paywall2VC {
    private func configureNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle"),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemGreen
    }
}


//if package1Button.isSelected == true {
//    package1Button.configuration = selectPackage(title: "1", subtitle: "Month", style: .filled())
//    package2Button.isSelected = false
//    package3Button.isSelected = false
//} else if package2Button.isSelected == true {
//    package1Button.isSelected = false
//    package3Button.isSelected = false
//} else if package3Button.isSelected == true {
//    package1Button.isSelected = false
//    package2Button.isSelected = false
//}
