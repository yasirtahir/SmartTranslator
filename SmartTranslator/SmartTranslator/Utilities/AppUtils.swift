//
//  AppUtils.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 12/04/2021.
//

import Foundation
import UIKit

class AppUtils: NSObject {
    
    static var API_KEY : String {
        let client : Dictionary<String, String> = getAGConnectServices(Key: "client") as! Dictionary<String, String>
        return client["api_key"]!
    }
    
    static func getAGConnectServices(Key:String) -> Any {
        if let path = Bundle.main.path(forResource: "agconnect-services", ofType: "plist") {
            // If your plist contain root as Dictionary
            if let file = NSDictionary(contentsOfFile: path) as? [String: Any] {
                return file[Key] as Any
            }
        }
        return ""
    }
    
    static func showAlertView(title:String?, message:String?, viewController:UIViewController) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .default, handler: nil)
        alert.addAction(cancelAction)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showConfirmationAlertView(title:String?, message:String?, viewController:UIViewController, completion: @escaping (_ success: Bool) -> Void) -> Void {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "NO",
                                         style: .default, handler: nil)
        
        let okAction = UIAlertAction(title: "YES",
                                     style: .default) { (action) in
            completion(true)
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func loadSupportedLanguages() -> [LanguageModel]? {
        if let url = Bundle.main.url(forResource: "SupportedLanguages", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.supportedLangs
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    static func getSelectedLanguage(langCode: String) -> LanguageModel? {
        let lang = self.loadSupportedLanguages()
        
        var selectedLang : LanguageModel?
        
        if lang != nil {
            for i in 0..<lang!.count {
                let currentLang = lang![i]
                if(currentLang.code == langCode){
                    selectedLang = currentLang
                }
            }
        }
        
        return selectedLang
    }
    
    static func showLanguageSelector(isAutoEnabled: Bool, viewController:UIViewController, completion: @escaping (_ selectedLanguage: LanguageModel) -> Void) -> Void {
        
        var supportedLanguages = self.loadSupportedLanguages()
        
        if supportedLanguages == nil {
            return
        }
        
        if isAutoEnabled {
            supportedLanguages!.insert(LanguageModel.init(langName: "Auto", code: "auto"), at: 0)
        }
        
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)

        for i in 0..<supportedLanguages!.count {
            
            let btnAction = LanguageAlertAction(title: supportedLanguages![i].langName, style: .default) { (action) in
                let actionClicked = action as! LanguageAlertAction
                let languageModel = actionClicked.languageModel
                completion(languageModel!)
            }
            
            btnAction.languageModel = supportedLanguages![i]
            alert.addAction(btnAction)
        }
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func getCurrentDateTime() -> String {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        return formatter.string(from: currentDateTime)
    }
    
    static func saveData(fromText: String, toText: String, fromLang: String, toLang: String){
        var history = self.getTranslationHistory()
        
        history.insert(TranslationHistoryModel.init(dateTime: getCurrentDateTime(), fromText: fromText, toText: toText, fromLang: fromLang, toLang: toLang), at: 0)

        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: history, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "TranslationHistory")
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
    
    static func clearHistory(){
        let history: [TranslationHistoryModel] = []
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: history, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: "TranslationHistory")
            UserDefaults.standard.synchronize()
        } catch {
            print(error)
        }
    }
    
    static func getTranslationHistory() -> [TranslationHistoryModel]{
        let decoded  = UserDefaults.standard.data(forKey: "TranslationHistory")
        if decoded != nil {
            do {
                let result = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded!) as? [TranslationHistoryModel]
                if result != nil {
                    return result!
                } else {
                    return []
                }
            } catch {
                print(error)
                return []
            }
        } else {
            return []
        }
    }
}

class LanguageAlertAction: UIAlertAction {
    var languageModel: LanguageModel?
}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

