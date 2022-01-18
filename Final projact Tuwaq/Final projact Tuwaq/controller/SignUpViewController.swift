//
//  SignUpViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 02/01/2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
  
    let db = Firestore.firestore()

    var Universitie = [" جامعه الملك سعود","جامعه الملك عبدالعزيز" ,"جامعه الامير سطام بن عبدالعزيز","جامعه الإمام جامعه المجمعه","جامعه شقراء","جامعه ام القرى","جامعه نجران","جامعه تبوك","جامعه الطائف"]
    
    @IBOutlet weak var NameTextFiled: UITextField!
    
    @IBOutlet weak var UniversitieTextFiled: UITextField!
    
    
    @IBOutlet weak var EmailTextFiled: UITextField!
    
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    var pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameTextFiled.customTextfield()
        EmailTextFiled.customTextfield()
        passwordTextFiled.customTextfield()
        UniversitieTextFiled.customTextfield()
        
        
       // createArticleOutlet.layer.cornerRadius = 20

       pickerView.delegate = self
      pickerView.dataSource = self

        UniversitieTextFiled.inputView = pickerView
        UniversitieTextFiled.textAlignment = .right
     
    }
    
    @IBAction func creatNewUsearBouton(_ sender: Any) {
        
        creatNewUsear(Email: EmailTextFiled.text!, Password: passwordTextFiled.text!)
        
    }
    
    @IBAction func signinAcountBouton(_ sender: Any) {
        
        SignInUser(Email: EmailTextFiled.text!, Password: passwordTextFiled.text!)
    }
  
    
    func creatNewUsear(Email:String,Password:String){
        Auth.auth().createUser(withEmail: Email, password: Password) { authResult, error in
            
            if error == nil {
                
                self.db.collection("Users")
                   .addDocument(data:
                                   [
                                    "name" : "\(self.NameTextFiled.text!)",
                                    "email": "\(self.EmailTextFiled.text!)",
                                    "password": "\(self.passwordTextFiled.text!)",
                                    "Universitie": "\(self.UniversitieTextFiled.text!)",

                                       
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
    
    }
    
    
    func SignInUser(Email:String,Password:String){
    
    
        
        Auth.auth().signIn(withEmail: Email, password: Password) { AuthDataResult, error in
            
            if error == nil {
                
                self.performSegue(withIdentifier: "moveHome", sender: nil)
                
                print("yassssss")
                
                
            }else{
                
                print(error?.localizedDescription)
                
                print("Noooooooooo")
            }
            
        }
        
        
        
    }
    
    
    
    
}





extension SignUpViewController : UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Universitie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return Universitie[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        UniversitieTextFiled.text = Universitie[row]
        UniversitieTextFiled.resignFirstResponder()

    }

}
