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
    private let selectPicsVidsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .selectPhotos()
        return button
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = K.UnifiedColors.darkWhite
        progressView.progressTintColor = K.UnifiedColors.greenColor
        return progressView
    }()
    
    private let explanationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        label.text = "Archive \n photos or videos right from \n your photo library✨"
        return label
    }()
    
    private let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "FrontPageLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var URLFiles: [URL] = []
    
    private var subscriptionCheck: Bool = false
    
    private var filesToDelete: [URL] = []
    
    private let computedLogoSize = UIScreen.main.bounds.width / 1.45
    
    private let shapeLayer = CAShapeLayer()
    
    private var updatedProgress: Double = 0.0
    
    private let animationDispatchGroup = DispatchGroup()
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Archive"
        configureNavBarButtons()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = K.UnifiedColors.lightGray
        addShapeLayer()
        setConstraints()
        
        selectPicsVidsButton.addTarget(self, action: #selector(selectPicsVidsButtonTapped), for: .touchUpInside)
        
        progressView.setProgress(0.0, animated: false)
        
        overrideUserInterfaceStyle = .dark
        
        illustrationImageView.isHidden = true
        
        progressView.isHidden = true
    }
    
    // MARK: - UI Intercation methods
    @objc private func settingBarButtonTapped() {
        let rootVC = SettingsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .automatic
        present(navVC, animated: true)
    }
    
    @objc private func questionBarButtonTapped() {
        let rootVC = PlanOptionsVC()
        let navVC = UINavigationController(rootViewController: rootVC)
        navVC.modalPresentationStyle = .automatic
        present(navVC, animated: true)
        
        UIView.animate(withDuration: 15) {
            self.progressView.setProgress(0.9, animated: true)
        }
        
//        UIView.animate(withDuration: 4, delay: .zero, options: .curveEaseOut) {
//            self.progressView.setProgress(0.7, animated: true)
//        } completion: { bool in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
////                self.progressView.setProgress(0.0, animated: true)
//            }
//        }
    }
    
    @objc private func selectPicsVidsButtonTapped() {
        showPhotoLibrary()
    }
    
    private func showPhotoLibrary() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 20
        config.filter = .any(of: [.videos, .images])
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        
        picker.tabBarItem.badgeColor = K.UnifiedColors.greenColor
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Animation
    func addShapeLayer() {
        let circularPath = UIBezierPath(
            arcCenter: view.center,
            radius: 150,
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
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func performAnim() {
        print("Attemting to animate stroke")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        animationDispatchGroup.enter()
        basicAnimation.toValue = 1
        basicAnimation.duration = 100
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "basicAnim")
        
        animationDispatchGroup.notify(queue: .main) {
            if self.updatedProgress == 1.0 {
                basicAnimation.duration = 1
//                basicAnimation.toValue = 1.0
                
                self.shapeLayer.add(basicAnimation, forKey: "basicAnim")
            }
            
        }
    }
}
// MARK: - PHP Delegate
extension HomeVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let dispatchGroup = DispatchGroup()
        
        if results != [] {
            selectPicsVidsButton.isEnabled = false
            
            navigationItem.rightBarButtonItem?.isEnabled = false
            navigationItem.leftBarButtonItem?.isEnabled = false
            
            // Starts animation
            DispatchQueue.main.async {
                self.performAnim()
            }
            
            // Each results output
            results.forEach { result in
                dispatchGroup.enter()
                
                // Checks the kind of results and works with them respectfully
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
                        if let urls = url {
                            do {
                                try self.saveToDocs(url: urls, fileType: urls.pathExtension)
                                dispatchGroup.leave()
                            } catch {
                                print(error.localizedDescription)
                                dispatchGroup.leave()
                            }
                        }
                    }
                }
                
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                        if let urls = url {
                            do {
                                try self.saveToDocs(url: urls, fileType: urls.pathExtension)
                                dispatchGroup.leave()
                            } catch {
                                print(error.localizedDescription)
                                dispatchGroup.leave()
                            }
                        }
                    }
                }
            }
            // Once the result has been finished, the written files get zipped and then deleted from the storage.
            dispatchGroup.notify(queue: .main) {
                self.zipFile(pathr: self.URLFiles)
            }
        }
    }
}
// MARK: - File manipulation methods
extension HomeVC {
    
    // To save chosen files into document directory
    private func saveToDocs(url: URL, fileType: String) throws {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = documentDirectory.appendingPathComponent("\(UUID()).\(fileType)")
        let fileData = try Data(contentsOf: url)
        try fileData.write(to: fileName)
        URLFiles.append(fileName)
    }
    
    
    // MARK: - Zip files
    // To arhive saved files into a zip container
    private func zipFile(pathr: [URL]) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        do {
            let zipFilePath = documentDirectory.appendingPathComponent("archive_13579.zip")
            
            print(zipFilePath)
            
            try Zip.zipFiles(paths: pathr, zipFilePath: zipFilePath, password: nil, compression: .BestCompression, progress: { progress in
                
                if progress == 1.0 {
                    DispatchQueue.main.async {
                        self.updatedProgress = progress
                        self.animationDispatchGroup.leave()
                    }
                }
                
                if progress == 1.0 {
                    DispatchQueue.main.async {
                        
                        if self.URLFiles != [] {
                            self.shareFile(fileURL: zipFilePath)
                            
                            self.filesToDelete.append(zipFilePath)
                        }
                        
                        for files in self.URLFiles {
                            do {
                                try FileManager.default.removeItem(at: files)
                                self.URLFiles.removeAll()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            })
        }
        catch {
            print("Something went wrong - \(error.localizedDescription)")
        }
    }

    // MARK: - Share
    // To share a file
    private func shareFile(fileURL: URL) {
        let items = [fileURL] as [Any]
        let avc = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // Apps to exclude sharing to
        avc.excludedActivityTypes = [
            //            UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList
        ]
        
        // Present the shareView on iPhone
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.present(avc, animated: true, completion: nil)
        }
        
        // Delete shared file
        avc.completionWithItemsHandler = { [weak self] (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if activityType == nil {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print(error.localizedDescription)
                }
                self?.selectPicsVidsButton.isEnabled = true
                
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
            } else {
                print(error?.localizedDescription as Any)
                
                self?.selectPicsVidsButton.isEnabled = true
                
                self?.navigationItem.rightBarButtonItem?.isEnabled = true
                self?.navigationItem.leftBarButtonItem?.isEnabled = true
            }
        }
        
    }
}

// MARK: - Constraints ans sizing
extension HomeVC {
    private func setConstraints() {
        view.addSubview(selectPicsVidsButton)
        view.addSubview(illustrationImageView)
        view.addSubview(progressView)
 
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
        contraints.append(selectPicsVidsButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(selectPicsVidsButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(selectPicsVidsButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20))
        contraints.append(selectPicsVidsButton.heightAnchor.constraint(equalToConstant: computeSize(num: 5.3)))
        
        contraints.append(illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(illustrationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        contraints.append(illustrationImageView.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(illustrationImageView.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(illustrationImageView.heightAnchor.constraint(equalToConstant: computedLogoSize))

        contraints.append(progressView.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(progressView.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor))
        contraints.append(progressView.heightAnchor.constraint(equalToConstant: 5))
        
        NSLayoutConstraint.activate(contraints)
    }
    
    private func computeSize(num: Double) -> CGFloat {
        let computedSize = UIScreen.main.bounds.width / num
        return computedSize
    }
}

// MARK: - Navigation Bar config
extension HomeVC {
    private func configureNavBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(settingBarButtonTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = K.UnifiedColors.greenColor
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info.circle"),
            style: .plain,
            target: self,
            action: #selector(questionBarButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = K.UnifiedColors.greenColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
        
        config.attributedTitle = AttributedString("Select from library", attributes: container)
        
        return config
    }
    

}
