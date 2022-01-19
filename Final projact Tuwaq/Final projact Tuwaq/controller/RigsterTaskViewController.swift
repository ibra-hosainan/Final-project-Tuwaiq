//
//  RigsterTaskViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 10/01/2022.
//

import UIKit

import Firebase

class RigsterTaskViewController: UIViewController {
    
    
    let db = Firestore.firestore()
    let datePicker = UIDatePicker()
    var toolbar = UIToolbar();
    
    @IBOutlet weak var subjactTextFiled: UITextField!
    @IBOutlet weak var deteTextFiled: UITextField!
    @IBOutlet weak var descrabtionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showDatePicker()
        hideKeyboardWhenTappedAround()
        
        //frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
        
        // toolbar.frame = CGRect(x: 100, y: 100, width: 60 , height: 60)
    }
    
    @IBAction func saveData(_ sender: Any) {
        
        let subjact = subjactTextFiled.text!
        let dete = deteTextFiled.text!
        let descraption = descrabtionTextView.text!
        
        if subjact == "" && dete == ""{
            
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
            
            data(subjact: subjact, dete: dete, descrabtion: descraption)
            
        }
    }
}


extension RigsterTaskViewController {
    
    
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
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        //ToolBar
        
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        deteTextFiled.inputAccessoryView = toolbar
        deteTextFiled.inputView = datePicker
        
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        deteTextFiled.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}
