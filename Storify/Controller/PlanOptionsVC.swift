//
//  PlanOptionsVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/13/22.
//

import UIKit
import StoreKit

class PlanOptionsVC: UIViewController {
    
    
    // MARK: - Variables and UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "ImageTest")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Unlimited Access"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "To all features"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let planDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "♾️ Unlimited archives.\n🚀 Export anywhere.\n❌ No ads.\n😇 Huge support for future updates."
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    private let monthlyPlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowColor = UIColor.systemCyan.cgColor
        button.layer.shadowOpacity = 0.50
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        return button
    }()
    
    private let yearlyPlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowColor = UIColor.systemPurple.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        return button
    }()
    
    private let planTermsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cancel subscription up to 24 hours before trial ends. You will be charged only after 3 days."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.minimumScaleFactor = 5
        label.textColor = K.UnifiedColors.darkWhite
        label.textAlignment = .center
        return label
    }()
    
    private let restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Restore Purchases", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(K.UnifiedColors.greenColor, for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .highlighted)
        return button
    }()
    
    let monthlyPlanID = "Storify_Monthy_Sub_101"
    
    let yearlyPlanID = "Storify_Yearly_Sub_101"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.UnifiedColors.darkGray
        
        SKPaymentQueue.default().add(self)
        
//        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(planDescriptionLabel)
        view.addSubview(monthlyPlanButton)
        view.addSubview(yearlyPlanButton)
        view.addSubview(planTermsLabel)
        view.addSubview(restorePurchasesButton)
        overrideUserInterfaceStyle = .dark
        
        monthlyPlanButton.configuration = returnButtonConfig(
            title: "Try 3 days free",
            subtitle: "Then Monthly - 3.99$",
            buttonStyle: .filled(),
            color: K.UnifiedColors.darkWhite,
            showIndicator: false
        )
        monthlyPlanButton.addTarget(self, action: #selector(monthlyButtonPressed), for: .touchUpInside)
        
        yearlyPlanButton.configuration = returnButtonConfig(
            title: "Try 3 days free",
            subtitle: "Then Yearly - 29.99$",
            buttonStyle: .filled(),
            color: K.UnifiedColors.darkWhite,
            showIndicator: false
        )
        yearlyPlanButton.addTarget(self, action: #selector(yearlyPlanActivate), for: .touchUpInside)
        
        restorePurchasesButton.addTarget(self, action: #selector(restorePressed), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()

        titleLabel.font = UIFont.systemFont(ofSize: computedSize(num: 12.8), weight: .bold) // CGFloat 25
        subtitleLabel.font = UIFont.systemFont(ofSize: computedSize(num: 20), weight: .medium) // CGFloat 16
        planDescriptionLabel.font = UIFont.systemFont(ofSize: computedSize(num: 22.85), weight: .semibold) // CGFloat 14
        planTermsLabel.font = UIFont.systemFont(ofSize: computedSize(num: 26.6), weight: .regular)
        restorePurchasesButton.titleLabel?.font = UIFont.systemFont(ofSize: computedSize(num: 26.6), weight: .medium)
        
    }
    
    
// MARK: - Button functions
    
    @objc private func monthlyButtonPressed() {
        
//        monthlyPlanButton.configuration = returnButtonConfig(
//            title: "",
//            subtitle: "",
//            buttonStyle: .filled(),
//            color: .white,
//            showIndicator: true
//        )
        
        activateMonthlyPlan()
    }
}

// MARK: - Constraints and configurations
extension PlanOptionsVC {
    func setConstraints() {
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
//        contraints.append(imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
//        contraints.append(imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
//        contraints.append(imageView.topAnchor.constraint(equalTo: view.topAnchor))
//        contraints.append(imageView.heightAnchor.constraint(equalToConstant: computedSize(num: 2.13))) // CGFloat 150
        
        contraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(titleLabel.topAnchor.constraint(equalTo: layout.topAnchor)) // CGFloat 25
        contraints.append(titleLabel.heightAnchor.constraint(equalToConstant: computedSize(num: 9.14))) //CGFloat 35
        
        contraints.append(subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor))
        contraints.append(subtitleLabel.heightAnchor.constraint(equalToConstant: computedSize(num: 20))) // CGFloat 16
        
        contraints.append(planDescriptionLabel.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(planDescriptionLabel.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(planDescriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: computedSize(num: 21.3))) // CGFloat 15
        contraints.append(planDescriptionLabel.heightAnchor.constraint(equalToConstant: computedSize(num: 4.57))) // CGFloT 17
        
        contraints.append(monthlyPlanButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(monthlyPlanButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(monthlyPlanButton.topAnchor.constraint(equalTo: planDescriptionLabel.bottomAnchor, constant: computedSize(num: 21.3))) // CGFloat 15
        contraints.append(monthlyPlanButton.heightAnchor.constraint(equalToConstant: computedSize(num: 5.3))) // CGFloar 60
        
        contraints.append(yearlyPlanButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(yearlyPlanButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(yearlyPlanButton.topAnchor.constraint(equalTo: monthlyPlanButton.bottomAnchor, constant: computedSize(num: 32))) // CGFloat 10
        contraints.append(yearlyPlanButton.heightAnchor.constraint(equalToConstant: computedSize(num: 5.3))) // CGFloar 60
        
        contraints.append(planTermsLabel.topAnchor.constraint(equalTo: yearlyPlanButton.bottomAnchor, constant: 20)) // CGFloat 10
        contraints.append(planTermsLabel.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(planTermsLabel.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(planTermsLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor))

        
        contraints.append(restorePurchasesButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor))
        contraints.append(restorePurchasesButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor))
//        contraints.append(restorePurchasesButton.topAnchor.constraint(equalTo: planTermsLabel.bottomAnchor, constant: 5))
        contraints.append(restorePurchasesButton.heightAnchor.constraint(equalToConstant: 50))
        
        NSLayoutConstraint.activate(contraints)
    }
    
    private func returnButtonConfig(title: String, subtitle: String, buttonStyle: UIButton.Configuration, color: UIColor, showIndicator: Bool) -> UIButton.Configuration {
        var config: UIButton.Configuration = buttonStyle
//        config.title = title
//        config.subtitle = subtitle
        config.titleAlignment = .center
        config.baseBackgroundColor = color
        config.baseForegroundColor = .black
        config.cornerStyle = .large
        config.showsActivityIndicator = showIndicator
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: computedSize(num: 16), weight: .medium) // CGFloat 20
        
        var container2 = AttributeContainer()
        container2.font = UIFont.systemFont(ofSize: computedSize(num: 20), weight: .regular) // CGFloat 16
        
        config.attributedTitle = AttributedString(title, attributes: container)
        config.attributedSubtitle = AttributedString(subtitle, attributes: container2)
        return config
    }
    


}

// MARK: - Sizing methods
extension PlanOptionsVC {
    func computedSize(num: Double) -> CGFloat {
        let computedSize = UIScreen.main.bounds.width / num
        return computedSize
    }
}


// MARK: - iAP Methods
extension PlanOptionsVC: SKPaymentTransactionObserver {
    @objc func activateMonthlyPlan() {
        
        if SKPaymentQueue.canMakePayments() {
            print("Can make payments")
            
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = monthlyPlanID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            print("Can't make payments")
        }
    }
    
    @objc func yearlyPlanActivate() {
        if SKPaymentQueue.canMakePayments() {
            print("Can make payments")
            
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = yearlyPlanID
            SKPaymentQueue.default().add(paymentRequest)
            
        } else {
            print("Can't make payments")
        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                // User payment succesfful
                print("transaction successful")
                
//                setAdsRemoved()
                                
                SKPaymentQueue.default().finishTransaction(transaction)
                
                navigationItem.setLeftBarButton(nil, animated: true)
                
            } else if transaction.transactionState == .failed {
                // Payment failed
                
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("transaction failed due to error: \(errorDescription)")
                }
                
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .restored {
                
//                setAdsRemoved()
                
                navigationItem.setRightBarButton(nil, animated: true)
                navigationItem.setLeftBarButton(nil, animated: true)
                
                print("transaction restored")
                
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    @objc func restorePressed() {
        SKPaymentQueue.default().restoreCompletedTransactions()
    }

    func UnlockPremiumFeatures() {
        /// Step 7, add user defaults method to save the fact of purchase
        UserDefaults.standard.set(true, forKey: monthlyPlanID)
    }
}



//constant: computedSize(num: 12.8)
