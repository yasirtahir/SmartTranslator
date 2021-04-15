//
//  SplashViewController.swift
//  SmartTranslator
//
//  Created by Yasir Tahir Ali on 12/04/2021.
//

import UIKit
import Lottie

class SplashViewController: BaseViewController {

    @IBOutlet weak var animationView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showAppIntro()
    }
    
    func showAppIntro(){
        DispatchQueue.main.async {
            self.animationView.animation = Animation.named("intro_animation")
            self.animationView.contentMode = .scaleAspectFit
            self.animationView.play(fromFrame: AnimationFrameTime.init(30), toFrame: AnimationFrameTime.init(256), loopMode: .playOnce) { (completed) in
                // Let's open Other Screen once the animation is completed
                self.performSegue(withIdentifier: "goToServiceIntro", sender: nil)
            }
        }
    }
    
}
