//
//  AddSabHomeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 12/01/2022.
//

import UIKit
import Firebase
class AddSubHomeViewController: UIViewController {

    let db = Firestore.firestore()

    var courseObject : course? = nil

    
    @IBOutlet weak var absenceDayTextFiled: UITextField!
    
    
    @IBOutlet weak var dateTextFiled: UITextField!
    
    
    @IBOutlet weak var timesAbsenceTextFiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func saveData(_ sender: Any) {
        
        let absenceDay = absenceDayTextFiled.text!
        let date = dateTextFiled.text!
        let timesAbsenc = Double(timesAbsenceTextFiled.text!)!
        data(day: "\( absenceDay)", dete: "\( date)", ratio: timesAbsenc)
    }
    
    func data(day : String , dete  : String, ratio : Double){
        
        let userEmail = Auth.auth().currentUser!.email!

        
        db.collection("Course").document("\(userEmail)-\(   courseObject?.name)").collection("Abcents").document().setData([
            "userEmail" : "\(Auth.auth().currentUser!.email!)",
            "day": "\(day)",
            "dete" : "\(dete)",
          "ratio": "\(ratio)",

        ]) { error in
      print("noooooo")

        }
    
    
    
    }


}
