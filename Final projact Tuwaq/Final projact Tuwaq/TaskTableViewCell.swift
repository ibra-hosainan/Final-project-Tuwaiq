//
//  TaskTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 09/01/2022.
//

import UIKit
import Firebase
class TaskTableViewCell: UITableViewCell {

    let db = Firestore.firestore()

    @IBOutlet weak var subjactTextFiled: UITextField!
    
    @IBOutlet weak var DeteTextFiled: UITextField!
    
    @IBOutlet weak var DescrabtionTextFiled: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func saveDataBouton(_ sender: Any) {
        
        let subjact = subjactTextFiled.text
        let dete = DeteTextFiled.text
        let descranbtion = DescrabtionTextFiled.text
        
        data(subjact: subjact!, dete: dete!, descrabtion: descranbtion!)
        
    }
    
    func data(subjact : String , dete  : String, descrabtion : String ){
        
        
        let userEmail = Auth.auth().currentUser!.email!
            
        self.db.collection("Task").document("\(userEmail)-\(subjact)").setData(  [
            "userEmail" : "\(Auth.auth().currentUser!.email!)",
            "subject" : "\(subjact)",
             "dete" : "\(dete)",
            "descrabtion": descrabtion,
               
           ])
            { error in
                   if error == nil {
                       print("New document has been created...")
                   } else {
                       print("error\(error!.localizedDescription)")
                   }
                   
               }
        
        
        
        
        
        
    }

}
