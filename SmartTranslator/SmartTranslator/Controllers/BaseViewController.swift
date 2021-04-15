//
//  BaseViewController.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 12/04/2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate() // This will set the Status bar color to white
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// Helper methods
extension BaseViewController {
    func displayResponse(message: String){
        AppUtils.showAlertView(title: nil, message: message, viewController: self)
    }
    
    func openLink(link: String){
        guard let url = URL(string: link) else { return }
        UIApplication.shared.open(url)
    }
}
