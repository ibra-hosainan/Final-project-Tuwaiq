//
//  SubHomeTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 04/01/2022.
//

import UIKit
import Firebase

class SubHomeTableViewCell: UITableViewCell {

    
    var courseObject : course? = nil

    let db = Firestore.firestore()
    
    @IBOutlet weak var dayLabel: UILabel!
    
    
    @IBOutlet weak var detaLabel: UILabel!
    
    
  
    @IBOutlet weak var ratiooLabel: UILabel!
    
    

    
    @IBAction func save(_ sender: Any) {
    
//        let day = TodayTextFiled.text
//        let date = DateTextFiled.text
//        let ratio = Double(ratioLable.text!)!
////
////
//        data(day: "\(day!)", dete: "\(date!)", ratio: ratio)
        
        print("........")
//        let alert = UIAlertController(title: "", message: "ادخل قيمه", preferredStyle: .alert)
//        let action = UIAlertAction(title: "OK", style: .default)
//        alert.addAction(action)
//
       // self.present(alert, animated: true)

     
    }
    
//    func data(day : String , dete  : String, ratio : Double){
//
//        let userEmail = Auth.auth().currentUser!.email!
//
//
//        db.collection("Course").document("\(userEmail)-\(courseObject!.name)").collection("Abcents").document().setData([
//
//            "userEmail" : "\(Auth.auth().currentUser!.email!)",
//            "day": "\(day)",
//            "dete" : "\(dete)",
//          "ratio": "\(ratio)",
//
//        ]) { error in
//
//
//        }
//
//
//
//    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }

}
