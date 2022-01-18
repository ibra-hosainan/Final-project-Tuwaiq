//
//  AddSabHomeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 12/01/2022.
//

import UIKit
import Firebase
class AddSubHomeViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
  //var arrday = ["السبت","الاحد","الاثنين","الثلاثاء","الاربعاء","الخميس"]
    
    var arrayCountabcant = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return arrayCountabcant.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
   
        return arrayCountabcant[row]
        
    }
   
   
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
   
           timesAbsenceTextFiled.text = arrayCountabcant[row]
           timesAbsenceTextFiled.resignFirstResponder()

   
       }
    
    
    

    let db = Firestore.firestore()
    
    let datePicker = UIDatePicker()
    var toolbar = UIToolbar();

    var courseObject : course? = nil
    
    var pickerView = UIPickerView()

    
    @IBOutlet weak var absenceDayTextFiled: UITextField!
    
    
    @IBOutlet weak var dateTextFiled: UITextField!
    
    
    @IBOutlet weak var timesAbsenceTextFiled: UITextField!
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
    
        showDatePicker()
        
        pickerView.delegate = self
       pickerView.dataSource = self
      
        timesAbsenceTextFiled.inputView = pickerView
        timesAbsenceTextFiled.textAlignment = .right
        
  
    }
    
   
    
    @IBAction func saveData(_ sender: Any) {
        
        let absenceDay = absenceDayTextFiled.text!
        let date = dateTextFiled.text!
        
        
        if absenceDay == "" && date == ""{
            
            let alert = UIAlertController(title: "", message: "ادخل قيمه", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        } else {
            let timesAbsenc = Double(timesAbsenceTextFiled.text!)!
            
            
            let alert = UIAlertController(title: "", message: "تمت الاضافه", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default ,handler: { action in
                
                self.dismiss(animated: true, completion: nil)

            })
            alert.addAction(action)
            present(alert, animated: true)
          
            
            data(day: "\( absenceDay)", dete: "\( date)", ratio: timesAbsenc)
            
        }
       
        
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

