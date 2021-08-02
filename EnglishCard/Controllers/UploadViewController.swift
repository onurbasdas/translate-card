//
//  UploadViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import FirebaseFirestore


class UploadViewController: UIViewController {
    
    @IBOutlet weak var turkishText: UITextField!
    @IBOutlet weak var englishText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var db: Firestore!
    var childArray = [Child]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let firestoreDatabase = Firestore.firestore()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let childArray = ["turkish" : turkishText.text!, "english" : englishText.text!] as [String: Any]
         firestoreDatabase.collection("Users").document(userID).collection("Cards").addDocument(data: childArray, completion: { (error) in
            if error != nil {
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            } else {
                self.turkishText.text = ""
                self.englishText.text = ""
                self.tabBarController?.selectedIndex = 1
            }
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        turkishText.resignFirstResponder()
        englishText.resignFirstResponder()
        return(true)
    }
}
