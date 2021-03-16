//
//  UpdateVC.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 11.02.2021.
//

import UIKit
import Firebase

class UpdateVC: UIViewController {
    
    
    
    @IBOutlet weak var turkishUpdateText: UITextField!
    @IBOutlet weak var englishUpdateText: UITextField!
    
    
    var selectedTurkishNames : String =  ""
    var selectedEnglishNames : String = ""
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turkishUpdateText.text = selectedTurkishNames
        englishUpdateText.text = selectedEnglishNames
        
        let myColor : UIColor = UIColor.white
        turkishUpdateText.layer.borderColor = myColor.cgColor
        turkishUpdateText.layer.borderWidth = 1.0
        englishUpdateText.layer.borderColor = myColor.cgColor
        englishUpdateText.layer.borderWidth = 1.0
    }
    
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toTableVC", sender: nil)
    }
    
}
