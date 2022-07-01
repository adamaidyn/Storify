//
//  Commented.swift
//  Storify
//
//  Created by Adm Aidyn on 6/22/22.
//

import Foundation
//extension PlanOptionsVC: SKPaymentTransactionObserver {
//    @objc func activateMonthlyPlan() {
//        
//        if SKPaymentQueue.canMakePayments() {
//            print("Can make payments")
//            
//            let paymentRequest = SKMutablePayment()
//            paymentRequest.productIdentifier = monthlyPlanID
//            SKPaymentQueue.default().add(paymentRequest)
//            
//        } else {
//            print("Can't make payments")
//        }
//    }
//    
//    @objc func yearlyPlanActivate() {
//        if SKPaymentQueue.canMakePayments() {
//            print("Can make payments")
//            
//            let paymentRequest = SKMutablePayment()
//            paymentRequest.productIdentifier = yearlyPlanID
//            SKPaymentQueue.default().add(paymentRequest)
//            
//        } else {
//            print("Can't make payments")
//        }
//    }
//    
//    
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//            if transaction.transactionState == .purchased {
//                // User payment succesfful
//                print("transaction successful")
//                
////                setAdsRemoved()
//                                
//                SKPaymentQueue.default().finishTransaction(transaction)
//                
//                navigationItem.setLeftBarButton(nil, animated: true)
//                
//            } else if transaction.transactionState == .failed {
//                // Payment failed
//                
//                if let error = transaction.error {
//                    let errorDescription = error.localizedDescription
//                    print("transaction failed due to error: \(errorDescription)")
//                }
//                
//                SKPaymentQueue.default().finishTransaction(transaction)
//                
//            } else if transaction.transactionState == .restored {
//                
////                setAdsRemoved()
//                
//                navigationItem.setRightBarButton(nil, animated: true)
//                navigationItem.setLeftBarButton(nil, animated: true)
//                
//                print("transaction restored")
//                
//                SKPaymentQueue.default().finishTransaction(transaction)
//            }
//        }
//    }
//    
//    @objc func restorePressed() {
//        SKPaymentQueue.default().restoreCompletedTransactions()
//    }
//
//    func UnlockPremiumFeatures() {
//        /// Step 7, add user defaults method to save the fact of purchase
//        UserDefaults.standard.set(true, forKey: monthlyPlanID)
//    }
//}


//constant: computedSize(num: 12.8)

//        UIView.animate(withDuration: 4, delay: .zero, options: .curveEaseOut) {
//            self.progressView.setProgress(0.7, animated: true)
//        } completion: { bool in
//            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
////                self.progressView.setProgress(0.0, animated: true)
//            }
//        }

//            , let info = info, error == nil, !userCancelled

//extension PlanOptionsVC {
//    private func presentAlert(title: String, message: String) {
//        // create the alert
//        let alert = UIAlertController(
//            title: title,
//            message: message,
//            preferredStyle: UIAlertController.Style.alert
//        )
//
//        // add an action (button)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//
//        // show the alert
//        present(alert, animated: true, completion: nil)
//    }
//}

//let explanationLabel: UILabel = {
//    let label = UILabel()
//    label.translatesAutoresizingMaskIntoConstraints = false
//    label.numberOfLines = 0
//    label.textAlignment = .center
//    label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
//    label.text = "Archive \n photos or videos right from \n your photo library✨"
//    return label
//}()

//    private func returnSubscribedButton() -> UIButton.Configuration {
//        var config: UIButton.Configuration = .filled()
//        config.baseBackgroundColor = K.UnifiedColors.darkWhite
//        config.baseForegroundColor = .black
//        config.cornerStyle = .large
//
//        var container = AttributeContainer()
//        container.font = UIFont.systemFont(ofSize: computedSize(num: 16), weight: .medium) // CGFloat 20 // Title config
//
//        config.attributedTitle = AttributedString("Subscribed", attributes: container)
//
//        return config
//    }

//var comingFromDefaults = UserDefaults.standard

//planOptionsVC.comingFromDefaults.set(true, forKey: "ComingFromPicker")

//            if userCancelled == false && error == nil && self?.comingFromDefaults.bool(forKey: "ComingFromPicker") == true {
//                self?.paymentDispatchGroup.leave()
//            }

//                if progress == 1.0 {
//                    DispatchQueue.main.async {
//                        if self.URLFiles != [] {
//                            self.shareFile(fileURL: zipFilePath)
//
//                            self.filesToDelete.append(zipFilePath)
//                        }
//                        for files in self.URLFiles {
//                            do {
//                                try FileManager.default.removeItem(at: files)
//                                self.URLFiles.removeAll()
//                            } catch {
//                                print(error.localizedDescription)
//                            }
//                        }
//                    }
//                }

//        computedSize(num: 26.6)

//        navigationItem.leftBarButtonItem = UIBarButtonItem(
//            image: UIImage(systemName: "info.circle"),
//            style: .plain,
//            target: self,
//            action: #selector(didTapQuestionBarButton)
//        )
//        navigationItem.leftBarButtonItem?.tintColor = K.UnifiedColors.greenColor

//                rootVC.comingFromDefaults.set(false, forKey: "ComingFromPicker")
