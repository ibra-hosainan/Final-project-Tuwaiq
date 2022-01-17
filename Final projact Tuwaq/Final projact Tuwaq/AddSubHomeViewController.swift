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
    
    let datePicker = UIDatePicker()
    var toolbar = UIToolbar();

    var courseObject : course? = nil
   
//    var a: SubHomeViewController = SubHomeViewController()
//       func anotherMethod() {
//           a.someMethod {
//               self.courseObject?.name
//           }
     
    
    @IBOutlet weak var absenceDayTextFiled: UITextField!
    
    
    @IBOutlet weak var dateTextFiled: UITextField!
    
    
    @IBOutlet weak var timesAbsenceTextFiled: UITextField!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
        showDatePicker()
        // Do any additional setup after loading the view.
    }
    
   
    
    @IBAction func saveData(_ sender: Any) {
        
        let absenceDay = absenceDayTextFiled.text!
        let date = dateTextFiled.text!
        let timesAbsenc = Double(timesAbsenceTextFiled.text!)!
        
        print("r : ",timesAbsenc)
        data(day: "\( absenceDay)", dete: "\( date)", ratio: timesAbsenc)
        print("absenceDay : ", absenceDay ,"timesAbsenc : ",timesAbsenc )
        
//        if absenceDay == nil && date == nil {
//
//            let alert = UIAlertController(title: "", message: "ادخل قيمه", preferredStyle: .alert)
//            let action = UIAlertAction(title: "OK", style: .default)
//            alert.addAction(action)
//            present(alert, animated: true)
//
//        }else{
//
//
//
//        }
        
    }
    
    func data(day : String , dete  : String, ratio : Double){
        
        let userEmail = Auth.auth().currentUser!.email!

        
        db.collection("Course").document("\(userEmail)-\(courseObject!.name)").collection("Abcents").document().setData([
            "userEmail" : "\(Auth.auth().currentUser!.email!)",
            "day": "\(day)",
            "dete" : "\(dete)",
          "ratio": "\(ratio)",

        ]) { error in
            if error == nil{
                
                print("yassss")
            }else{
                
                print("noooooo")
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

        dateTextFiled.inputAccessoryView = toolbar
        dateTextFiled.inputView = datePicker
      

    }
    
    @objc func donedatePicker(){

     let formatter = DateFormatter()
     formatter.dateFormat = "dd/MM/yyyy"
    dateTextFiled.text = formatter.string(from: datePicker.date)
     self.view.endEditing(true)
   }

   @objc func cancelDatePicker(){
      self.view.endEditing(true)
    }
    

    


}

