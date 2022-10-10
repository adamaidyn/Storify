//
//  PlanOptionsExt..swift
//  Storify
//
//  Created by Adm Aidyn on 6/26/22.
//

import UIKit
import RevenueCat
import StoreKit

// MARK: - Constraints
extension PlanOptionsVC {
    func setConstraints() {
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
        let currentUIScreenSize = UIScreen.main.bounds.width
        
        contraints.append(titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 15)) // CGFloat 25
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
        
        contraints.append(planTermsLabel.topAnchor.constraint(equalTo: yearlyPlanButton.bottomAnchor, constant: 10)) // CGFloat 10
        contraints.append(planTermsLabel.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(planTermsLabel.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(planTermsLabel.centerXAnchor.constraint(equalTo: layout.centerXAnchor))
        
        if currentUIScreenSize == 320 {
            contraints.append(restorePurchasesButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor))
            contraints.append(restorePurchasesButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor))
            contraints.append(restorePurchasesButton.heightAnchor.constraint(equalToConstant: 50))
            contraints.append(restorePurchasesButton.widthAnchor.constraint(equalToConstant: 200))
        } else {
            contraints.append(restorePurchasesButton.centerXAnchor.constraint(equalTo: layout.centerXAnchor))
            contraints.append(restorePurchasesButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor))
            contraints.append(restorePurchasesButton.heightAnchor.constraint(equalToConstant: 100))
            contraints.append(restorePurchasesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40))
            contraints.append(restorePurchasesButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40))
        }

        contraints.append(subscribedBackView.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(subscribedBackView.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(subscribedBackView.topAnchor.constraint(equalTo: planDescriptionLabel.bottomAnchor, constant: computedSize(num: 16)))
        contraints.append(subscribedBackView.bottomAnchor.constraint(equalTo: planTermsLabel.topAnchor, constant: computedSize(num: -16)))
        
        contraints.append(subscribedLabel.centerXAnchor.constraint(equalTo: subscribedBackView.centerXAnchor))
        contraints.append(subscribedLabel.centerYAnchor.constraint(equalTo: subscribedBackView.centerYAnchor))
        
        contraints.append(discountImageView.trailingAnchor.constraint(equalTo: yearlyPlanButton.trailingAnchor, constant: computedSize(num: -32)))
        contraints.append(discountImageView.topAnchor.constraint(equalTo: yearlyPlanButton.topAnchor))
        contraints.append(discountImageView.bottomAnchor.constraint(equalTo: yearlyPlanButton.bottomAnchor, constant: -5))
        contraints.append(discountImageView.widthAnchor.constraint(equalToConstant: 50))
        
        contraints.append(discountLabel.leadingAnchor.constraint(equalTo: discountImageView.leadingAnchor))
        contraints.append(discountLabel.trailingAnchor.constraint(equalTo: discountImageView.trailingAnchor))
        contraints.append(discountLabel.topAnchor.constraint(equalTo: discountImageView.topAnchor))
        contraints.append(discountLabel.bottomAnchor.constraint(equalTo: discountImageView.bottomAnchor, constant: -10))
        
        
        NSLayoutConstraint.activate(contraints)
    }
    
    // MARK: - Button configs
    func returnButtonConfig(title: String, subtitle: String, buttonStyle: UIButton.Configuration, color: UIColor, showIndicator: Bool) -> UIButton.Configuration {
        var config: UIButton.Configuration = buttonStyle
        config.titleAlignment = .center
        config.baseBackgroundColor = color
        config.baseForegroundColor = .black
        config.cornerStyle = .large
        config.showsActivityIndicator = showIndicator
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: computedSize(num: 17), weight: .medium) // CGFloat 20
        
        var container2 = AttributeContainer()
        container2.font = UIFont.systemFont(ofSize: computedSize(num: 20), weight: .regular) // CGFloat 16
        
        config.attributedTitle = AttributedString(title, attributes: container)
        config.attributedSubtitle = AttributedString(subtitle, attributes: container2)
        return config
    }
    
    func returnActivityButtonConfig() -> UIButton.Configuration {
        var config: UIButton.Configuration = .filled()
        config.baseBackgroundColor = K.UnifiedColors.darkWhite
        config.cornerStyle = .large
        config.showsActivityIndicator = true
        config.baseForegroundColor = .black
        
        return config
    }
}

// MARK: - Misc methods
extension PlanOptionsVC {
    func computedSize(num: Double) -> CGFloat {
        let computedSize = UIScreen.main.bounds.width / num
        return computedSize
    }
    
    func presentAlert(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // show the alert
        present(alert, animated: true, completion: nil)
    }
}


// MARK: - Revenue Cat
extension PlanOptionsVC {
    func checkSubscriptionStatus() {
        Purchases.shared.getCustomerInfo { [weak self] info, error in
            guard let info = info, error == nil else { return }
            print("This is info \(info)")
            self?.unlockFeatures()
        }
    }
    
    // MARK: - fetch packages
    func fetchMonthlyPackage(completion: @escaping (Package) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else { return }
            
            guard let _ = offerings.all.first?.value.availablePackages.first else { return }
            
            guard let monthlyPackage = offerings.offering(identifier: Identifiers.RevenueCatIDs.offeringsID)?.availablePackages[0] else { return } // Monthly package
            
            completion(monthlyPackage)
        }
    }
    
    func fetchYearlyPackage(completion: @escaping (Package) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            guard let offerings = offerings, error == nil else { return }
                        
            guard let _ = offerings.current?.availablePackages[0] else { return }
            
            guard let yearlyPackage = offerings.offering(identifier: Identifiers.RevenueCatIDs.offeringsID)?.availablePackages[1] else { return } // Yearly package
            
            print("Yearly available package \(yearlyPackage)")
            
            completion(yearlyPackage)
        }
    }
    
    // MARK: - Purchase
    func purchase(package: Package) {
        Purchases.shared.purchase(package: package) { [weak self] transaction, info, error, userCancelled in
            guard let transaction = transaction else { return }
            
            print(transaction.purchaseDate)
            
            if userCancelled == true || error != nil {
                DispatchQueue.main.async {
                    self?.monthlyPlanButton.configuration = self?.returnButtonConfig(
                        title: K.TextLabels.packageTitle,
                        subtitle: K.TextLabels.monthlySubstitle,
                        buttonStyle: .filled(),
                        color: K.UnifiedColors.darkWhite,
                        showIndicator: false
                    )
                
                    self?.yearlyPlanButton.configuration = self?.returnButtonConfig(
                        title: K.TextLabels.packageTitle,
                        subtitle: K.TextLabels.yearlySubtitle,
                        buttonStyle: .filled(),
                        color: K.UnifiedColors.darkWhite,
                        showIndicator: false
                    )
                }
            }
            
            if userCancelled == false && error == nil && self?.ifComingFromHome == true {
                self?.paymentDispatchGroup.leave()
            }
            
            if info?.entitlements[Identifiers.RevenueCatIDs.yearlyEntitlementID]?.isActive == true || info?.entitlements[Identifiers.RevenueCatIDs.monthlyEntitlementID]?.isActive == true {
                self?.unlockFeatures()
                
                self?.dismiss(animated: true)
            }
        }
    }
    
    // MARK: - Restore
    func restorePurchases() {
        Purchases.shared.restorePurchases { [weak self] info, error in
            guard let info = info, error == nil else { return }
            
            self?.unlockFeatures()
            
            if info.entitlements.all[Identifiers.RevenueCatIDs.monthlyEntitlementID]?.isActive == true || info.entitlements.all[Identifiers.RevenueCatIDs.monthlyEntitlementID]?.isActive == true {
 
                if self?.ifComingFromHome == true {
                    self?.paymentDispatchGroup.leave()
                    self?.dismiss(animated: true)
                }
            } else {
                
            }
        }
    }
    
    // MARK: - Unlock features
    func unlockFeatures() {
        Purchases.shared.getCustomerInfo { [weak self] info, error in
            guard let info = info, error == nil else { return }
            
            // Monthly sub is active
            if info.entitlements.all[Identifiers.RevenueCatIDs.monthlyEntitlementID]?.isActive == true {
                self?.planOptionsUserDefaults.set(true, forKey: K.VariablesIDs.planOptionsUserDefaultsKey)
                
                DispatchQueue.main.async {
                    print("Monthly Sub is activated")
                    
                    self?.monthlyPlanButton.isHidden = true
                    self?.yearlyPlanButton.isHidden = true
                    self?.subscribedBackView.isHidden = false
                    self?.subscribedLabel.isHidden = false
                }
                // Yearly sub is active
            } else if info.entitlements.all[Identifiers.RevenueCatIDs.yearlyEntitlementID]?.isActive == true {
                self?.planOptionsUserDefaults.set(true, forKey: K.VariablesIDs.planOptionsUserDefaultsKey)
                
                DispatchQueue.main.async {
                    print("Yearly Sub is activated")
                    
                    self?.monthlyPlanButton.isHidden = true
                    self?.yearlyPlanButton.isHidden = true
                    self?.subscribedBackView.isHidden = false
                    self?.subscribedLabel.isHidden = false
                }
            } else {
                // No subscription
                self?.planOptionsUserDefaults.set(false, forKey: K.VariablesIDs.planOptionsUserDefaultsKey)
                
                DispatchQueue.main.async {
                    print("Sub isn't activated")
                    
                    self?.monthlyPlanButton.configuration = self?.returnButtonConfig(
                        title: K.TextLabels.packageTitle,
                        subtitle: K.TextLabels.monthlySubstitle,
                        buttonStyle: .filled(),
                        color: K.UnifiedColors.darkWhite,
                        showIndicator: false
                    )
                    
                    self?.yearlyPlanButton.configuration = self?.returnButtonConfig(
                        title: K.TextLabels.packageTitle,
                        subtitle: K.TextLabels.yearlySubtitle,
                        buttonStyle: .filled(),
                        color: K.UnifiedColors.darkWhite,
                        showIndicator: false
                    )
                    
                    self?.subscribedBackView.isHidden = true
                    self?.subscribedLabel.isHidden = true
                }
            }
        }
    }
}
