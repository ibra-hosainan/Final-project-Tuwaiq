//
//  ViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 02/01/2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    let db = Firestore.firestore()

    @IBOutlet weak var EmailTextFiled: UITextField!
    
    @IBOutlet weak var passwordTextFiled: UITextField!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        EmailTextFiled.customTextfield()
        passwordTextFiled.customTextfield()
    }
    
    

    @IBAction func ForgetPassword(_ sender: Any) {
        
    }
    
    @IBAction func signinBoutton(_ sender: Any) {
        SignInUser(Email: EmailTextFiled.text!, Password: passwordTextFiled.text!)
    }
    
   
    
    func SignInUser(Email:String,Password:String){
    
        Auth.auth().signIn(withEmail: Email, password: Password) { AuthDataResult, error in
            
            if error == nil {
                
                self.performSegue(withIdentifier: "moveHome", sender: nil)
                
                print("yasss")
                
                
            }else{
                
                print(error?.localizedDescription)
                
                print("nooooooo")
            }
            
        }
        
        
        
    }
    
    
    
    
}
extension UITextField {
    
    func customTextfield (){
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        addSubview(underLineView)
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3),
            underLineView.heightAnchor.constraint(equalToConstant: 1 )
        ])
    }
    
    
    
    
   
}

extension UITextField{
    @IBInspectable var placeholderColor: UIColor? {
        get {return self.placeholderColor}
        set {self.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor : newValue!])}
    }
}


