//
//  ForgotPasswordViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 19/01/2022.
//

import UIKit
import Firebase
class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var EmailTextFiled: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmailAcation(_ sender: Any) {
        
        
        resetPassword()
    }
    
    
    
    func resetPassword(){
            
                    Auth.auth().sendPasswordReset(withEmail: EmailTextFiled.text!) { error in
                        
                        if error == nil {
                            
                            let alert = UIAlertController(title: "Alert", message: "The reset link has been send", preferredStyle: .alert)
                            
                            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                            
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                                
                                self.dismiss(animated: true, completion: nil)
                            }
                        }
                        
                    }
                }

}
