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
    var db: Firestore!
    var childArray = [Child]() {
        didSet {
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        db = Firestore.firestore()
//        loadData()
        
              getDataFirestore()
    }
    
//    func loadData() {
//        let user = Auth.auth().currentUser
//        db.collection("Users").document((user?.uid)!).collection("Cards").getDocuments() {
//            QuerySnapshot, error in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                self.childArray = QuerySnapshot!.documents.compactMap({Child(dictionary: $0.data())})
//
//
//                self.userTurkishArray.removeAll(keepingCapacity: false)
//                self.userEnglishArray.removeAll(keepingCapacity: false)
//
//                for document in QuerySnapshot!.documents {
//
//                    if let english = document.get("english") as? String {
//                        self.userEnglishArray.append(english)
//                        print(document.documentID)
//                    }
//                    if let turkish = document.get("turkish") as? String {
//                        self.userTurkishArray.append(turkish)
//                    }
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//    }
    
    
    
    
    
    
    
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

//                         let documentId = document.documentID

                         if let english = document.get("english") as? String {
                             self.userEnglishArray.append(english)
                             print(document.documentID)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
//        let child = childArray[indexPath.row]
//        cell.turkishLabel.text = child.turkish
//        cell.englishLabel.text = child.english
        cell.turkishLabel.text = userTurkishArray[indexPath.row]
        cell.englishLabel.text = userEnglishArray[indexPath.row]
        
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
                                        //print("\(document.documentID) => \(document.data())")
                                        self.db.collection("Users").document((user?.uid)!).collection("Cards").document("\(document.documentID)").delete()
                                    }
                                }})

            userTurkishArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
        
    }
}




