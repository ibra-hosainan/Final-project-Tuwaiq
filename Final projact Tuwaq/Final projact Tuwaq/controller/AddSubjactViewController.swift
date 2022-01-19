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
    var arrayCountHours = ["1","2","3","4","5","6","7","8","9","10"]
    var pickerView = UIPickerView()
    
    
    @IBOutlet weak var subjactTextFiled: UITextField!
    @IBOutlet weak var hourseTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        hourseTextFiled.inputView = pickerView
        hourseTextFiled.textAlignment = .right
        hideKeyboardWhenTappedAround()
        
    }
    
    
    
    @IBAction func saveData(_ sender: Any) {
        
        let subjact = subjactTextFiled.text!
        let hours =  hourseTextFiled.text!
        
        if subjact == "" && hours == ""{
            
            let alert = UIAlertController(title: "", message: "ادخل قيمه", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
            
        }else{
            
            let alert = UIAlertController(title: "", message: "تمت الاضافه", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default ,handler: { action in
                
                self.dismiss(animated: true, completion: nil)
                
            })
            alert.addAction(action)
            present(alert, animated: true)
            data(subject: subjact, hourse: hours)
        }
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


extension AddSubjactViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrayCountHours.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return arrayCountHours[row]
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        hourseTextFiled.text = arrayCountHours[row]
        hourseTextFiled.resignFirstResponder()
        
        
    }
}
