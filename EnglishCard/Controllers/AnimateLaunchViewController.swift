//
//  AnimateLaunchViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 8.09.2021.
//

import UIKit
import SwiftyGif

class AnimateLaunchViewController: UIViewController, SwiftyGifDelegate {
    
    @IBOutlet var appcentLabel: UILabel!
    @IBOutlet var logoImageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       conf()
    }
    
    func conf() {
        logoImageView.layer.cornerRadius = 16
        logoImageView.delegate = self
        do {
            let gif = try UIImage(gifName: "1amw.gif")
            setLabelsHiddenAnimation()
            self.logoImageView.setGifImage(gif, loopCount: 1)
        } catch {
            print(error)
        }
    }
    
    func setLabelsHiddenAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.appcentLabel.alpha = 0
        } completion: { (_) in
            self.setLabelsShowAnimation()
        }
    }
    
    func setLabelsShowAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.appcentLabel.alpha = 1
        } completion: { (_) in
            self.setLabelsHiddenAnimation()
        }
    }

    func gifDidStop(sender: UIImageView) {
        let vc = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(identifier: "backLoginVC")
        self.view.window?.rootViewController = vc
    }
}
