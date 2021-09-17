//
//  SettingsViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import AMTabView

class SettingsViewController: UIViewController, TabItem {
    
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var imageProfile: UIImageView!
    
    var tabImage: UIImage? {
      return UIImage(named: "tab3")
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        profilePictureUpload()
    }
    
    func configureUI() {
        logoutButton.frame = CGRect(x: 0.0, y: 0.0, width: logoutButton.frame.width, height: logoutButton.frame.height)
        logoutButton.clipsToBounds = true
        logoutButton.layer.cornerRadius = logoutButton.frame.width / 2
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.layer.borderWidth = 2.0
        infoLabel.text = Auth.auth().currentUser?.email
    }
    
    func profilePictureUpload() {
        imageProfile.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageProfile.addGestureRecognizer(gestureRecognizer)
        let profilePic = UserDefaults.standard.object(forKey: "profilePicture") as? NSData
        if profilePic == nil {
            imageProfile.image = UIImage(named: "profilePlaceHolder")
        }else {
            imageProfile.image = UIImage(data: profilePic! as Data)
        }
        imageProfile.roundedImage()
    }
    
    @IBAction func logoutClicked(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            loadHomeScreen(name: "Auth", identifier: "backLoginVC")
            
        } catch {
            print("Error")
        }
    }
}
extension SettingsViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage{
            imageProfile.contentMode = .scaleAspectFit
            imageProfile.image = image
            let imageData : NSData =  (image.pngData() as NSData?)!
            UserDefaults().setValue(imageData, forKey: "profilePicture")
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @objc func chooseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
}

extension UIImageView {
    
    func roundedImage() {
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.white.cgColor
    }
}
