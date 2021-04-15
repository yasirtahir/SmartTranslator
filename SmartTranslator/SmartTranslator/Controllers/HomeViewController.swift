//
//  HomeViewController.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 12/04/2021.
//

import UIKit
import Lottie
import MLTranslate
import MLLangDetection

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var btnLangOne: UIButton!
    @IBOutlet weak var btnLangTwo: UIButton!
    @IBOutlet weak var btnSwitchLang: UIButton!
    @IBOutlet weak var edtTxtMessage: UITextView!
    @IBOutlet weak var btnHistory: UIButton!
    @IBOutlet weak var txtLblResult: UILabel!
    @IBOutlet weak var animationLoader: AnimationView!
    @IBOutlet weak var animationView: UIView!
    
    var mlRemoteLangDetectSettings:  MLRemoteLangDetectorSetting?
    var mlRemoteLangDetect:  MLRemoteLangDetector?
    var mlRemoteTranslateSettings: MLRemoteTranslateSetting?
    var langTo: LanguageModel?
    var langFrom: LanguageModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initVariables()
    }
    
    @IBAction func OnClicked(_ sender: UIButton) {
        if sender == btnSwitchLang {
            toggleLanguages()
        } else if sender == btnLangOne {
            selectFromLanguage()
        } else if sender == btnLangTwo {
            selectToLanguage()
        } else if sender == btnHistory {
            self.performSegue(withIdentifier: "goToHistory", sender: nil)
        }
    }
}

// This extension is responsible for basic functionalities
extension HomeViewController: UITextViewDelegate {
    
    func initVariables(){
        self.initAnimation()
        self.initUI()
        self.initLangDetect()
    }
    
    func initAnimation(){
        // Init Loader animation
        self.animationLoader.animation = Animation.named("translate_loader")
        self.animationLoader.contentMode = .scaleAspectFit
        self.animationLoader.loopMode = .loop
        self.animationLoader.animationSpeed = 2
        self.animationView.isHidden = true
    }
    
    func initUI(){
        // Init Default Languages
        if self.langFrom == nil {
            self.langFrom = LanguageModel.init(langName: "Auto", code: "auto")
        }
        // Init Default Languages
        if self.langTo == nil {
            self.langTo = LanguageModel.init(langName: "English", code: "en")
        }
        
        self.setButtonsTitle()
        self.edtTxtMessage.delegate = self
    }
    
    func initLangDetect(){
        // Init Lang Detector
        mlRemoteLangDetectSettings = MLRemoteLangDetectorSetting.init(trustThreshold: 0.01)
        mlRemoteLangDetect = MLRemoteLangDetector.init(setting: mlRemoteLangDetectSettings!)
    }
    
    func initLangTranslate(){
        // Init Translator
        mlRemoteTranslateSettings = MLRemoteTranslateSetting.init(sourceLangCode: self.langFrom!.code, targetLangCode: self.langTo!.code)
        MLRemoteTranslator.sharedInstance().setRemoteTranslator(mlRemoteTranslateSettings!)
    }
    
    func toggleLanguages(){
        if !self.langFrom!.langName.contains("Auto") {
            let swapLang = self.langFrom
            self.langFrom = self.langTo
            self.langTo = swapLang
            self.setButtonsTitle()
            
            if edtTxtMessage.text.count > 0 && txtLblResult.text!.count > 0 {
                let swapText = edtTxtMessage.text!
                edtTxtMessage.text = txtLblResult.text!
                txtLblResult.text = swapText
            }
        }
    }
    
    func setButtonsTitle(){
        btnLangOne.setTitle(self.langFrom!.langName, for: .normal)
        btnLangTwo.setTitle(self.langTo!.langName, for: .normal)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.edtTxtMessage.resignFirstResponder()
            return false
        }
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 250
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if self.langFrom?.code == "auto" {
            // Detect Entered Language
            autoDetectLanguage(enteredText: textView.text)
        } else {
            // Translate the text directly
            translateText(enteredText: textView.text)
        }
    }
    
    func selectFromLanguage(){
        AppUtils.showLanguageSelector(isAutoEnabled: true, viewController: self) { (selectedLanguage) in
            self.langFrom = selectedLanguage
            self.setButtonsTitle()
            self.edtTxtMessage.text = ""
            self.txtLblResult.text = ""
        }
    }
    
    func selectToLanguage(){
        AppUtils.showLanguageSelector(isAutoEnabled: false, viewController: self) { (selectedLanguage) in
            self.langTo = selectedLanguage
            self.setButtonsTitle()
            self.edtTxtMessage.text = ""
            self.txtLblResult.text = ""
        }
    }
    
    func showLoader(){
        DispatchQueue.main.async {
            self.animationView.isHidden = false
            self.animationLoader.play()
        }
    }
    
    func hideLoader(){
        DispatchQueue.main.async {
            self.animationView.isHidden = true
            self.animationLoader.stop()
        }
    }
}

// This extension is responsible for MLLangDetect and MLTranslate related functions
extension HomeViewController {
    func autoDetectLanguage(enteredText: String){
        if enteredText.count > 1 {
            self.txtLblResult.text = "" // Reset the translated text
            self.showLoader()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.mlRemoteLangDetect?.syncFirstBestDetect(enteredText, addOnSuccessListener: { (lang) in
                    // Get the Language that user entered, incase unable to identify, please change auto to your language
                    let detectedLanguage = AppUtils.getSelectedLanguage(langCode: lang)
                    
                    if detectedLanguage == nil {
                        self.hideLoader()
                        self.displayResponse(message: "Oops! We are not able to detect your language 🧐 Please select your language from the list for better results 😉")
                        return // No Need to run the remaining code
                    }
                    
                    self.langFrom = detectedLanguage!
                    
                    // Once we detect the language, let's add Auto suffix to let user know that it's automatically detected
                    let langName = "\(String(describing: self.langFrom!.langName)) - Auto"
                    self.langFrom!.langName = langName
                    
                    // Let's update the buttons titles
                    self.setButtonsTitle()
                    
                    // Let's do the translation now
                    self.translateText(enteredText: enteredText)
                }, addOnFilureListener: { (exception) in
                    self.hideLoader()
                    self.displayResponse(message: "Oops! We are unable to process your request at the moment 😞")
                })
            }
        }
    }
    
    func translateText(enteredText: String){
        // Let's Init the translator with selected languages
        self.initLangTranslate()
        if enteredText.count > 1 {
            self.txtLblResult.text = "" // Reset the translated text
            self.showLoader()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                MLRemoteTranslator.sharedInstance().syncTranslate(enteredText) { (translatedText) in
                    self.txtLblResult.text = translatedText
                    self.saveTranslationHistory() // This function will save translation history
                    self.hideLoader()
                } addOnFailureListener: { (exception) in
                    self.hideLoader()
                    self.displayResponse(message: "Oops! We are unable to process your request at the moment 😞")
                }
            }
        } else {
            self.hideLoader()
            self.displayResponse(message: "Please write something 🧐")
        }
    }
    
    func saveTranslationHistory(){
        AppUtils.saveData(fromText: edtTxtMessage.text!, toText: txtLblResult.text!, fromLang: self.langFrom!.langName, toLang: self.langTo!.langName)
    }
}
