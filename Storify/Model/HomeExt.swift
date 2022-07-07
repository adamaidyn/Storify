//
//  HomeExt.swift
//  Storify
//
//  Created by Adm Aidyn on 6/26/22.
//

import UIKit
import PhotosUI
import Zip

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
            results.forEach { [weak self] result in
                dispatchGroup.enter()
                
                // Checks the kind of results and works with them respectfully
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.movie.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { [weak self] url, error in
                        if let urls = url {
                            do {
                                try self?.saveToDocs(url: urls, fileType: urls.pathExtension)
                                dispatchGroup.leave()
                            } catch {
                                print(error.localizedDescription)
                                dispatchGroup.leave()
                            }
                        }
                    }
                }
                
                if result.itemProvider.hasItemConformingToTypeIdentifier(UTType.image.identifier) {
                    result.itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { [weak self] url, error in
                        if let urls = url {
                            do {
                                try self?.saveToDocs(url: urls, fileType: urls.pathExtension)
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
            
            try Zip.zipFiles(paths: pathr, zipFilePath: zipFilePath, password: nil, compression: .BestCompression, progress: {  progress in
                if progress == 1.0 {
                    DispatchQueue.main.async {
                        self.updatedProgress = progress
                        self.animationDispatchGroup.leave()
                    }
                    
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
        
        let planOptionsVC = PlanOptionsVC()
        
        // Apps to exclude sharing to
        avc.excludedActivityTypes = [
            // UIActivity.ActivityType.airDrop,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList
        ]
        
        if planOptionsVC.planOptionsUserDefaults.bool(forKey: "SubscriptionIsActive") == false {
            planOptionsVC.paymentDispatchGroup.enter()
            planOptionsVC.ifComingFromHome = true
            if updatedProgress == 1.0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let navVC = UINavigationController(rootViewController: planOptionsVC)
                    navVC.modalPresentationStyle = .pageSheet
                    self.present(navVC, animated: true)
                }
            }
        }
        
        planOptionsVC.paymentDispatchGroup.notify(queue: .main) {
            self.hapticFeedback.notificationOccurred(.success)
            self.selectPicsVidsButton.isEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.present(avc, animated: true, completion: nil)
            }
            
        }
        
        // Delete shared file
        avc.completionWithItemsHandler = { [weak self] (activityType, completed: Bool, returnedItems: [Any]?, error: Error?) in
            if activityType == nil {
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self?.selectPicsVidsButton.isEnabled = true
                    
                    self?.navigationItem.rightBarButtonItem?.isEnabled = true
                    self?.navigationItem.leftBarButtonItem?.isEnabled = true
                }
            } else {
                DispatchQueue.main.async {
                    print(error?.localizedDescription as Any)
                    
                    self?.selectPicsVidsButton.isEnabled = true
                    
                    self?.navigationItem.rightBarButtonItem?.isEnabled = true
                    self?.navigationItem.leftBarButtonItem?.isEnabled = true
                }
            }
        }
    }
}

// MARK: - Constraints & sizing
extension HomeVC {
    func setConstraints() {
        var contraints = [NSLayoutConstraint]()
        
        let layout = view.layoutMarginsGuide
        
        contraints.append(selectPicsVidsButton.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(selectPicsVidsButton.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(selectPicsVidsButton.bottomAnchor.constraint(equalTo: layout.bottomAnchor, constant: -20))
        contraints.append(selectPicsVidsButton.heightAnchor.constraint(equalToConstant: computeSize(num: 5.3)))
        
        contraints.append(illustrationImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor))
        contraints.append(illustrationImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -1))
        contraints.append(illustrationImageView.leadingAnchor.constraint(equalTo: layout.leadingAnchor))
        contraints.append(illustrationImageView.trailingAnchor.constraint(equalTo: layout.trailingAnchor))
        contraints.append(illustrationImageView.heightAnchor.constraint(equalToConstant: computeSize(num: 1.35)))
        
        NSLayoutConstraint.activate(contraints)
    }
    
    func computeSize(num: Double) -> CGFloat {
        let computedSize = UIScreen.main.bounds.width / num
        return computedSize
    }
}

// MARK: - Navigation Bar config
extension HomeVC {
    func configureNavBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(didTapSettingsBarButton)
        )
        navigationItem.leftBarButtonItem?.tintColor = K.UnifiedColors.greenColor
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
public extension URL {

    var fileSize: Int? {
        let value = try? resourceValues(forKeys: [.fileSizeKey])
        return value?.fileSize
    }
}
