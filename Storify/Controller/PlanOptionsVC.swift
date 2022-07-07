//
//  PlanOptionsVC.swift
//  Storify
//
//  Created by Adm Aidyn on 6/13/22.
//

import UIKit
import RevenueCat
import StoreKit

class PlanOptionsVC: UIViewController {
    // MARK: - UI
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: K.AssetsNames.planOptionsVCBackgroundImage)
        imageView.contentMode = .scaleToFill
        
        return imageView
    }()
        
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.TextLabels.planOptionsVCTitle
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
     let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
         label.text = K.TextLabels.PlanOptionsSubtitle
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let planDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.TextLabels.planDescriptionText
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let monthlyPlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowColor = UIColor.systemCyan.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        return button
    }()
    
    let yearlyPlanButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.shadowOffset = CGSize(width: 0, height: 5)
        button.layer.shadowColor = UIColor.systemPurple.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 5
        button.layer.masksToBounds = false
        return button
    }()
    
    let planTermsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.TextLabels.planTermsText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.minimumScaleFactor = 5
        label.textColor = K.UnifiedColors.darkWhite
        label.textAlignment = .center
//        label.layer.shadowOffset = CGSize(width: 0, height: 3)
//        label.layer.shadowColor = UIColor.black.cgColor
//        label.layer.shadowOpacity = 1
//        label.layer.shadowRadius = 5
        return label
    }()
    
    let restorePurchasesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(K.TextLabels.restorePurchaseText, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.setTitleColor(K.UnifiedColors.greenColor, for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .highlighted)
        return button
    }()
    
    let subscribedBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerCurve = .continuous
        view.layer.cornerRadius = 25
        view.backgroundColor = K.UnifiedColors.darkWhite
        view.alpha = 0.70
        return view
    }()
    
    let subscribedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.TextLabels.subscribedText
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.numberOfLines = 0
        label.textColor = K.UnifiedColors.darkGray
        label.textAlignment = .center
        return label
    }()
    
    let discountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: K.AssetsNames.ribbonImageName)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let discountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = K.TextLabels.discountText
        label.textColor = K.UnifiedColors.darkWhite
        label.font = .systemFont(ofSize: 13, weight: .heavy)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - objects and variables
    var planOptionsUserDefaults = UserDefaults.standard
    
    let paymentDispatchGroup = DispatchGroup()
    
    let planOptionsHaptics = UINotificationFeedbackGenerator()
    
    var ifComingFromHome: Bool = false
    
    let product = SKProduct()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.UnifiedColors.darkGray
        view.addSubview(backgroundImageView)
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(planDescriptionLabel)
        view.addSubview(monthlyPlanButton)
        view.addSubview(yearlyPlanButton)
        view.addSubview(planTermsLabel)
        view.addSubview(restorePurchasesButton)
        view.addSubview(subscribedBackView)
        subscribedBackView.addSubview(subscribedLabel)
        yearlyPlanButton.addSubview(discountImageView)
        discountImageView.addSubview(discountLabel)
        
        overrideUserInterfaceStyle = .dark
        
        monthlyPlanButton.configuration = returnButtonConfig(
            title: "Try 3 days free",
            subtitle: "Then Monthly - 3.99$",
            buttonStyle: .filled(),
            color: K.UnifiedColors.darkWhite,
            showIndicator: false
        )
        monthlyPlanButton.addTarget(self, action: #selector(didTapMonthly), for: .touchUpInside)
        
        yearlyPlanButton.configuration = returnButtonConfig(
            title: "Try 3 days free",
            subtitle: "Then Yearly - 29.99$",
            buttonStyle: .filled(),
            color: K.UnifiedColors.darkWhite,
            showIndicator: false
        )
        yearlyPlanButton.addTarget(self, action: #selector(didTapYearly), for: .touchUpInside)
        
        restorePurchasesButton.addTarget(self, action: #selector(didTapRestore), for: .touchUpInside)
        
        subscribedBackView.isHidden = true
        subscribedLabel.isHidden = true
        
        checkSubscriptionStatus()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle.fill"),
            style: .done,
            target: self,
            action: #selector(dismissSelf)
        )
        
        navigationItem.rightBarButtonItem?.tintColor = K.UnifiedColors.greenColor
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backgroundImageView.frame = view.bounds
        
        setConstraints()
        
        titleLabel.font = UIFont.systemFont(ofSize: computedSize(num: 12.8), weight: .bold) // CGFloat 25
        subtitleLabel.font = UIFont.systemFont(ofSize: computedSize(num: 20), weight: .medium) // CGFloat 16
        planDescriptionLabel.font = UIFont.systemFont(ofSize: computedSize(num: 22.85), weight: .semibold) // CGFloat 14
        planTermsLabel.font = UIFont.systemFont(ofSize: computedSize(num: 26.6), weight: .regular)
        restorePurchasesButton.titleLabel?.font = UIFont.systemFont(ofSize: computedSize(num: 26.6), weight: .medium)
        subscribedBackView.layer.cornerRadius = computedSize(num: 12)
        subscribedLabel.font = .systemFont(ofSize: computedSize(num: 12), weight: .bold)
        discountLabel.font = .systemFont(ofSize: computedSize(num: 24), weight: .heavy)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // Deletes a zipped file in case the user didn't subscribe
        if planOptionsUserDefaults.bool(forKey: "SubscriptionIsActive") == false {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let zipFilePath = documentDirectory.appendingPathComponent("archive_13579.zip")
            do {
                try FileManager.default.removeItem(at: zipFilePath)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Button methods
    @objc private func didTapMonthly() {
        fetchMonthlyPackage { [weak self] package in
            self?.purchase(package: package)
            
            DispatchQueue.main.async {
                self?.monthlyPlanButton.configuration = self?.returnActivityButtonConfig()
            }
        }
    }
    
    @objc private func didTapYearly() {
        fetchYearlyPackage { [weak self] package in
            self?.purchase(package: package)
            
            DispatchQueue.main.async {
                self?.yearlyPlanButton.configuration = self?.returnActivityButtonConfig()
            }
        }
    }
    
    @objc private func didTapRestore() {
        restorePurchases()
    }
    
    @objc private func dismissSelf() {
        self.dismiss(animated: true)
    }
}
