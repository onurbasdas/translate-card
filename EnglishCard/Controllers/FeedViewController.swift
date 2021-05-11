//
//  FeedViewController.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 9.02.2021.
//

import UIKit
import Firebase
import FirebaseFirestore

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userTurkishArray = [String]()
    var userEnglishArray = [String]()
    var db: Firestore!
    var chosenTurkishText: String?
    var chosenEnglishText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        getDataFirestore()
        configureFeed()
    }
    
    func configureFeed() {
        let nib = UINib(nibName: "CardTableViewCell", bundle: nil)
        tableView.backgroundColor = UIColor(named: "main")
        tableView.register(nib, forCellReuseIdentifier: "CardTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func getDataFirestore() {
        let userID : String = (Auth.auth().currentUser?.uid)!
        let firestoreDatabase = Firestore.firestore()
        firestoreDatabase.collection("Users").document(userID).collection("Cards").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription as Any)
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userTurkishArray.removeAll(keepingCapacity: false)
                    self.userEnglishArray.removeAll(keepingCapacity: false)
                    for document in snapshot!.documents {
                        if let english = document.get("english") as? String {
                            self.userEnglishArray.append(english)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTurkishArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableViewCell", for: indexPath) as! CardTableViewCell
        cell.turkishText.text = userTurkishArray[indexPath.row]
        cell.englishText.text = userEnglishArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let turkish = userTurkishArray[indexPath.row]
            let user = Auth.auth().currentUser
            let collectionReference = db.collection("Users").document((user?.uid)!).collection("Cards")
            let query : Query = collectionReference.whereField("turkish", isEqualTo: turkish)
            query.getDocuments(completion: { (snapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    for document in snapshot!.documents {
                        
                        self.db.collection("Users").document((user?.uid)!).collection("Cards").document("\(document.documentID)").delete()
                    }
                }
            })
            userTurkishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let update = UIContextualAction(style: .normal, title: "Update") { [self] (action, view, nil) in
            chosenTurkishText = userTurkishArray[indexPath.row]
            chosenEnglishText = userEnglishArray[indexPath.row]
            performSegue(withIdentifier: "toUpdateVC", sender: self)
        }
        update.backgroundColor = UIColor(named: "main")
        return UISwipeActionsConfiguration(actions: [update])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toUpdateVC" {
            let destinationVC = segue.destination as! UpdateVC
            destinationVC.selectedTurkishNames = chosenTurkishText!
            destinationVC.selectedEnglishNames = chosenEnglishText!
        }
    }
}




