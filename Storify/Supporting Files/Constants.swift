//
//  Constants.swift
//  Storify
//
//  Created by Adm Aidyn on 6/15/22.
//

import Foundation
import UIKit

struct K {
    struct UnifiedColors {
        static let greenColor: UIColor = UIColor(red: 0.48, green: 0.78, blue: 0.30, alpha: 1.00)
        static let darkGray: UIColor = UIColor(red: 0.13, green: 0.16, blue: 0.19, alpha: 1.00)
        static let lightGray: UIColor = UIColor(red: 0.22, green: 0.24, blue: 0.27, alpha: 1.00)
        static let darkWhite: UIColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
    }
    struct TextLabels {
        static let animationKeypath = "strokeEnd"
        static let shapeLayerKey = "basicAnim"
        static let buttonConfigText = "Select from library"
        static let homeVCTitle = "Archive"
        static let planOptionsVCTitle = "Unlimited Access"
        static let PlanOptionsSubtitle = "To all features"
        static let planDescriptionText = "ā¾ļø Unlimited archives.\nš Export anywhere.\nā No ads.\nš Huge support for future updates."
        static let planTermsText = "Auto-renewable subscription,\n 1 month - 3.99$, 12 month - 29.99$ durations. After 3 days of trial Your subscription will be charged to your iTunes account at confirmation of purchase and will automatically renew (at the duration selected) unless auto-renew is turned off at least 24 hours before the end of the current period. Current subscription may not be cancelled during the active subscription period; however, you can manage your subscription and/or turn off auto-renewal by visiting your iTunes Account Settings after purchase.\n Privacy Policy is available in settings."
        static let restorePurchaseText = "Restore Purchases"
        static let subscribedText = "You're Subscribed!"
        static let discountText = "37% OFF"
        static let settingsTitle = "Settings"
         
        static let packageTitle = "Free for 3 days"
        static let monthlySubstitle = "Then Monthly - $3.99"
        static let yearlySubtitle = "Then Yearly - $29.99"
    }
    struct AssetsNames {
        static let illustrationImageName = "FrontPageLogo"
        static let planOptionsVCBackgroundImage = "pexels-albin-biju-3831422"
        static let ribbonImageName = "ribbon"
    }
    
    
    struct VariablesIDs {
        static let planOptionsUserDefaultsKey = "SubscriptionIsActive"
        static let supportWebPage = "https://sites.google.com/view/cherrydevs/support"
        static let privacyWebPage = "https://sites.google.com/view/cherrydevs/privacy"
        static let termsWebPage = "https://sites.google.com/view/cherrydevs/terms-conditions"
        static let reviewAppLink = "https://apps.apple.com/app/storify-zip-photos-videos/id1628718718?action=write-review"
        static let settingsTableViewCellID = "SettingsCell"
    }
}
