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

    
    
    @IBOutlet weak var NameTextFiled: UITextField!
    

    @IBOutlet weak var EmailTextFiled: UITextField!
    
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NameTextFiled.customTextfield()
        EmailTextFiled.customTextfield()
        passwordTextFiled.customTextfield()

     
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
