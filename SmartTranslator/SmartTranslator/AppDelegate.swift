//
//  AppDelegate.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 11/04/2021.
//

import UIKit
import MLTranslate
import MLLangDetection

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Setting API key so that we can use ML Kit for translation
        MLTranslateApplication.sharedInstance().setApiKey(AppUtils.API_KEY)
        MLLangDetectApplication.sharedInstance().setApiKey(AppUtils.API_KEY)
        
        return true
    }
}
