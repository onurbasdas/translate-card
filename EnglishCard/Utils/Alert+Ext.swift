//
//  Alert+Ext.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 28.06.2021.
//

import UIKit

extension UIViewController {
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loadHomeScreen(name: String, identifier: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: name, bundle: nil)
        let mainTabBarController = storyBoard.instantiateViewController(identifier: identifier)
        mainTabBarController.modalPresentationStyle = .fullScreen
        mainTabBarController.modalTransitionStyle = .crossDissolve
        self.present(mainTabBarController, animated: true, completion: nil)
    }
}
