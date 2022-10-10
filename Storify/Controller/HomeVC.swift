//
//  ViewController.swift
//  Storify
//
//  Created by Adm Aidyn on 6/5/22.
//

import UIKit
import PhotosUI
import Zip

class HomeVC: UIViewController {
    
    // MARK: - UI Elements and variables
    let selectPicsVidsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .selectPhotos()
        return button
    }()
    
    let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: K.AssetsNames.illustrationImageName)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var URLFiles: [URL] = []
    
    var filesToDelete: [URL] = []
    
    let computedLogoSize = UIScreen.main.bounds.width / 1.45
    
    let shapeLayer = CAShapeLayer()
    
    var updatedProgress: Double = 0.0
    
    let animationDispatchGroup = DispatchGroup()
    
    let hapticFeedback = UINotificationFeedbackGenerator()
    
    let hapticFeedBack2 = UIImpactFeedbackGenerator()
    
    var overallFilesSize: Double = 0.0
    
    var userDefaults = UserDefaults.standard
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = K.TextLabels.homeVCTitle
        configureNavBarButtons()
        
        let planOptions = PlanOptionsVC()

        if planOptions.planOptionsUserDefaults.bool(forKey: "SubscriptionIsActive") == false {
            selectPicsVidsButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = K.UnifiedColors.lightGray
        view.addSubview(selectPicsVidsButton)
        
        addShapeLayer()
        
        view.addSubview(illustrationImageView)
        
        overrideUserInterfaceStyle = .dark
        
        illustrationImageView.isHidden = false
        
        selectPicsVidsButton.addTarget(self, action: #selector(selectPicsVidsButtonTapped), for: .touchUpInside)
        
        userDefaults.set(5, forKey: "FreeTries")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setConstraints()
    }
    
    // MARK: - UI Interaction methods
    @objc func didTapSettingsBarButton() {
        let rootVC = SettingsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .automatic
        
        hapticFeedBack2.impactOccurred(intensity: 0.7)
        
        present(navVC, animated: true)
    }
    
    @objc func didTapQuestionBarButton() {
        let rootVC = PlanOptionsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .automatic
        
        rootVC.ifComingFromHome = false
        
        hapticFeedBack2.impactOccurred(intensity: 0.7)
        
        present(navVC, animated: true)
    }
    
    @objc func didTapRightBarButton() {
        navigationItem.rightBarButtonItem?.image = updateTries()
    }
    
    @objc func selectPicsVidsButtonTapped() {
        showPhotoLibrary()
    }
    
    private func updateTries() -> UIImage {
        if userDefaults.integer(forKey: "FreeTries") == 0 {
            let rootVC = PlanOptionsVC()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .automatic
            
            rootVC.ifComingFromHome = false
            
            hapticFeedBack2.impactOccurred(intensity: 0.7)
            
            present(navVC, animated: true)
        }
        switch navigationItem.rightBarButtonItem?.image {
        case UIImage(systemName: "5.circle"):
            userDefaults.set(4, forKey: "FreeTries")
            return UIImage(systemName: "4.circle")!
        case UIImage(systemName: "4.circle"):
            userDefaults.set(3, forKey: "FreeTries")
            return UIImage(systemName: "3.circle")!
        case UIImage(systemName: "3.circle"):
            userDefaults.set(2, forKey: "FreeTries")
            return UIImage(systemName: "2.circle")!
        case UIImage(systemName: "2.circle"):
            userDefaults.set(1, forKey: "FreeTries")
            return UIImage(systemName: "1.circle")!
        case UIImage(systemName: "1.circle"):
            userDefaults.set(0, forKey: "FreeTries")
            
            let rootVC = PlanOptionsVC()
            let navVC = UINavigationController(rootViewController: rootVC)
            navVC.modalPresentationStyle = .automatic
            
            rootVC.ifComingFromHome = false
            
            hapticFeedBack2.impactOccurred(intensity: 0.7)
            
            present(navVC, animated: true)
            return UIImage(systemName: "0.circle")!
        default:
            return UIImage(systemName: "5.circle")!
        }
    }
    
    private func showPhotoLibrary() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 50
        config.filter = .any(of: [.videos, .images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        picker.modalPresentationStyle = .fullScreen
        
        hapticFeedBack2.impactOccurred(intensity: 0.8)
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Animation
    private func addShapeLayer() {
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: computeSize(num: 2.5),
            startAngle: -CGFloat.pi / 2,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = K.UnifiedColors.greenColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = K.UnifiedColors.darkGray.cgColor
        
        view.layer.addSublayer(shapeLayer)
    }
    
    @objc func performAnim() {
        print("Attemting to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: K.TextLabels.animationKeypath)
        
        animationDispatchGroup.enter()
        basicAnimation.toValue = 0.77
        basicAnimation.duration = 200
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: K.TextLabels.shapeLayerKey)
        
        animationDispatchGroup.notify(queue: .main) {
            if self.updatedProgress == 1.0 {
                basicAnimation.toValue = 1
                basicAnimation.duration = 1
                basicAnimation.isRemovedOnCompletion = true
                self.shapeLayer.add(basicAnimation, forKey:  K.TextLabels.shapeLayerKey)
            }
        }
    }
}
// MARK: - UIButton config
extension UIButton.Configuration {
    static func selectPhotos() -> UIButton.Configuration {
        let computedTextSize = UIScreen.main.bounds.width / 17.7
        
        var config: UIButton.Configuration = .filled()
        config.titleAlignment = .center
        config.baseBackgroundColor = K.UnifiedColors.greenColor
        config.cornerStyle = .large
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: computedTextSize, weight: .medium) // CGFloat 20
        
        config.attributedTitle = AttributedString(K.TextLabels.buttonConfigText, attributes: container)
        
        return config
    }
}
