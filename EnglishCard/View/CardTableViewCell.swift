//
//  CardTableViewCell.swift
//  EnglishCard
//
//  Created by Onur Başdaş on 23.04.2021.
//

import UIKit
import Firebase

class CardTableViewCell: UITableViewCell {
    @IBOutlet var turkishText: UILabel!
    @IBOutlet var englishText: UILabel!
    @IBOutlet var btnCard: UIButton!
    @IBOutlet var backView: UIView!
    
    var userTurkishArray = [String]()
    var userEnglishArray = [String]()
    var isOpen = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        backView.layer.cornerRadius = 15
    }
    
    func configure() {
        btnCard.tintColor = .white
        let redValue = CGFloat(drand48())
        let greenValue = CGFloat(drand48())
        let blueValue = CGFloat(drand48())
        btnCard.backgroundColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
      //  backView.backgroundColor = .white
      

        backView.layer.masksToBounds = false
        backView.layer.cornerRadius = 15.0
        
        btnCard.layer.shadowColor = UIColor.gray.cgColor
        btnCard.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        btnCard.layer.shadowOpacity = 1.0
        btnCard.layer.masksToBounds = false
        btnCard.layer.cornerRadius = 15.0
        
        
    }
    
    @IBAction func btnFlip(_ sender: Any) {
        if isOpen {
            isOpen = false
            btnCard.setTitle(turkishText.text, for: .normal)
            UIView.transition(with: btnCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        } else {
            isOpen = true
            btnCard.setTitle(englishText.text, for: .normal)
            UIView.transition(with: btnCard, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnCard.setTitle(turkishText.text, for: .normal)
    }
    
}
