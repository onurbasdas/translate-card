//
//  SettingsViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    @IBOutlet var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        logoutButton.frame = CGRect(x: 0.0, y: 0.0, width: logoutButton.frame.width, height: logoutButton.frame.height)
        logoutButton.clipsToBounds = true
        logoutButton.layer.cornerRadius = logoutButton.frame.width/2.0
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.layer.borderWidth=2.0
    }
    
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewController", sender: nil)
        }catch{
            print("Error")
        }
        
    }
    
}
