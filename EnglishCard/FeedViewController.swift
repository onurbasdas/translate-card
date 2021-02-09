//
//  FeedViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var userTurkishArray = [String]()
    var userEnglishArray = [String]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFirestore()
    }
    
    func getDataFirestore() {
        let userID : String = (Auth.auth().currentUser?.uid)!
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Users").document(userID).collection("Cards").addSnapshotListener { (snapshot, error) in
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userTurkishArray.removeAll(keepingCapacity: false)
                    self.userEnglishArray.removeAll(keepingCapacity: false)
                    

                    for document in snapshot!.documents {
                        if let english = document.get("english") as? String {
                            self.userEnglishArray.append(english)
                            print(document)
                        }
                        if let turkish = document.get("turkish") as? String {
                            self.userTurkishArray.append(turkish)
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func removeDateFirestore() {
        let selectedID : String = (Auth.auth().currentUser?.uid)!
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTurkishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.turkishLabel.text = userTurkishArray[indexPath.row]
        cell.englishLabel.text = userEnglishArray[indexPath.row]
        
        return cell
    }
    
    
}
