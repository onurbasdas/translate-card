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
    
    var db = Firestore.firestore()
    
    var selectedTurkishNames : String?
    var selectedEnglishNames : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        turkishUpdateText.text = selectedTurkishNames
        englishUpdateText.text = selectedEnglishNames
    }
    
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "toTableVC", sender: nil)
        
        updateData()
        
    }
    
    func updateData(){
        let userID : String = (Auth.auth().currentUser?.uid)!

        // To update age and favorite color:
        let updateDataTurkish = db.collection("Users").document(userID).collection("Cards")
        let query : Query = updateDataTurkish.whereField("turkish", isEqualTo: selectedTurkishNames as Any)
        query.getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                for document in snapshot!.documents {
                    self.db.collection("Users").document(userID).collection("Cards").document("\(document.documentID)").updateData(([
                        "turkish" : self.selectedTurkishNames as Any,
                        "english" : self.selectedEnglishNames as Any
                    ])
                    )
                }
            }
        }
    }
    
}
