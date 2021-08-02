//
//  SignInExt.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 1.05.2021.
//

import UIKit
import Firebase
import FirebaseFirestore
import NVActivityIndicatorView

extension LogInViewController {
    func getSignIn() {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    self.startAnimation()
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            makeAlert(titleInput: "Error", messageInput: "Username/Password?")
        }
    }
    
    func startAnimation() {
        let loading = NVActivityIndicatorView(frame: .zero, type: .ballPulse, color: .systemPink, padding: 10)
        loading.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loading)
        NSLayoutConstraint.activate([
            loading.widthAnchor.constraint(equalToConstant: 50),
            loading.heightAnchor.constraint(equalToConstant: 50),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        loading.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3){
            loading.stopAnimating()
        }
    }
}
