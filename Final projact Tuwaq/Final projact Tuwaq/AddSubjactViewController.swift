//
//  AddSubjactViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 11/01/2022.
//

import UIKit
import Firebase
class AddSubjactViewController: UIViewController {
    let db = Firestore.firestore()

    @IBOutlet weak var subjactTextFiled: UITextField!
    
    @IBOutlet weak var hourseTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveData(_ sender: Any) {
        let subjact = subjactTextFiled.text!
        let hours =  hourseTextFiled.text!
        
        data(subject: subjact, hourse: hours)
    }
    
    

}


extension AddSubjactViewController {
    
    
    func data(subject : String , hourse  : String){
        
        
        let userEmail = Auth.auth().currentUser!.email!
            
        self.db.collection("Course").document("\(userEmail)-\(subject)").setData(  [
            "userEmail" : "\(Auth.auth().currentUser!.email!)",
            "TotalAlabcents": 0,
            "name" : "\(subject)",
            "credit": hourse,
               
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
