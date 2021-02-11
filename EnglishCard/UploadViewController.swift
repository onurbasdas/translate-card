//
//  UploadViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase


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
//        var firestoreReference : DocumentReference? = nil
        
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is" + userID)
        
        let childArray = ["turkish" : turkishText.text!, "english" : englishText.text!] as [String: Any]
        
         firestoreDatabase.collection("Users").document(userID).collection("Cards").addDocument(data: childArray, completion: { (error) in
            if error != nil{
                self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
            }else{
                self.turkishText.text = ""
                self.englishText.text = ""
                self.tabBarController?.selectedIndex = 1
            }
        })
        
    }
    
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    

}
