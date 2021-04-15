//
//  ServiceIntroViewController.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 12/04/2021.
//

import UIKit

class ServiceIntroViewController: BaseViewController {

    @IBOutlet weak var btnHuaweiMlKit: UIButton!
    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func OnClicked(_ sender: UIButton) {
        if sender == btnHuaweiMlKit {
            openLink(link: "https://developer.huawei.com/consumer/en/doc/development/HMSCore-Guides-V5/ios-real-time-translation-0000001062729936-V5")
        } else if sender == btnStart {
            self.performSegue(withIdentifier: "goToHome", sender: nil)
        }
    }
}
