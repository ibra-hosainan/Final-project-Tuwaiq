//
//  profileViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 13/01/2022.
//

import UIKit
import Firebase
import Lottie

class profileViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    let db = Firestore.firestore()
    let email = Auth.auth().currentUser!.email!
    
    @IBOutlet weak var darkModeSwitchOutlet: UISwitch!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var UniversityLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        getData()
        configureAnimation()
        //        let darkModeEnabled = defaults.bool(forKey: "darkModeEnabled")
        //
        //        if darkModeEnabled == true {
        //            view.backgroundColor = .black
        //        } else {
        //            view.backgroundColor = .white
        //        }
        
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        
        signOut()
    }
    
    @IBAction func darkModeSwitched(_ sender: Any) {
        
        if darkModeSwitchOutlet.isOn == true {
            //enable dark mode
            // DarkisOn = true
            
            //add a userDefault here so that the app will stay in dark mode
            defaults.set(true, forKey: "darkModeEnabled")
            
            
        } else if darkModeSwitchOutlet.isOn == false {
            
            defaults.set(false, forKey: "darkModeEnabled")
            
        }
    }
    
    
}

extension profileViewController {
    
    func signOut() {
        
        let alert = UIAlertController(title: "تنبيه", message: "هل أنت متأكد أنك تريد تسجيل الخروج؟", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "تسجيل الخروج", style: .destructive) { action in
            
            do {
                try Auth.auth().signOut()
                self.dismiss(animated: true, completion: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    func configureAnimation() {
        
        let animation = Animation.named("92280-ic-profile")
        let animationView = AnimationView(animation:animation)
        animationView.contentMode = .scaleAspectFill
        animationView.frame = CGRect(x: 160, y: 270, width: 100, height: 100)
        view.addSubview(animationView)
        animationView.play()
        animationView.loopMode = .playOnce
        animationView.animationSpeed = 1
       
    }
    
    func getData(){
        
        db.collection("Users").whereField("email", isEqualTo: self.email)
            .getDocuments { querySnapshot, error in
                
                if error == nil {
                    
                    let name = querySnapshot?.documents[0].get("name")
                    
                    let Universitie = querySnapshot?.documents[0].get("Universitie")!
                    
                    
                    self.nameLabel.text = "\(name!)"
                    self.UniversityLabel.text = "\(Universitie!)"
                    
                    
                } else {
                    
                }
            }
    }
}

