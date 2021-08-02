//
//  UpdateVC.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 11.02.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class UpdateVC: UIViewController {
    
    @IBOutlet weak var turkishUpdateText: UITextField!
    @IBOutlet weak var englishUpdateText: UITextField!
    
    
    var selectedTurkishNames : String?
    var selectedEnglishNames : String?
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        turkishUpdateText.text = selectedTurkishNames
        englishUpdateText.text = selectedEnglishNames
        configureUpdate()
    }
    
    func configureUpdate() {
        let myColor : UIColor = UIColor.white
        turkishUpdateText.layer.borderColor = myColor.cgColor
        turkishUpdateText.layer.borderWidth = 1.0
        englishUpdateText.layer.borderColor = myColor.cgColor
        englishUpdateText.layer.borderWidth = 1.0
    }
    
    func updateData()  {
        let user = Auth.auth().currentUser
        let collectionReference = db.collection("Users").document((user?.uid)!).collection("Cards")
        let query : Query = collectionReference.whereField("turkish", isEqualTo: self.selectedTurkishNames!)
        query.getDocuments(completion: { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                for document in snapshot!.documents {
                    self.db.collection("Users").document((user?.uid)!).collection("Cards").document("\(document.documentID)").updateData(["turkish": self.turkishUpdateText.text!, "english": self.englishUpdateText.text!])
                }
            }
        })
    }
    
    @IBAction func updateButtonClicked(_ sender: Any) {
        updateData()
        dismiss(animated: true, completion: nil)
    }
    
  
}
