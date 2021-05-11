//
//  SignUp.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 1.05.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

extension ViewController {
    func getSignUp() {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                    let firestoreNewUser: [String: Any] = [
                        "email": self.emailText.text!,
                        "password": self.passwordText.text!
                    ]
                    let newUser = Firestore.firestore()
                    let userID : String = (Auth.auth().currentUser?.uid)!
                    print("Current user ID is " + userID)
                    
                    newUser.collection("Users").document(userID).setData(firestoreNewUser){ err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!")
                            self.emailText.text = ""
                            self.passwordText.text = ""
                        }
                    }
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
    }
}
