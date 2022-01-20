//
//  HomeeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 11/01/2022.
//

import UIKit
import Firebase
import Lottie

class HomeeViewController: UIViewController {
    
    let db = Firestore.firestore()
    let refreshControl = UIRefreshControl()
    var arraySubjects : [course] = []
    var animation = Animation.named("8852-searching-for-word")
    var animationView : AnimationView?
    var arr : course?
    
    
    @IBOutlet weak var MyView: UIView!
    @IBOutlet weak var titleEmpty: UILabel!
    @IBOutlet weak var addSubjactButton: UIButton!
    @IBOutlet weak var myHomeeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //animationView = AnimationView(animation: animation)
        myHomeeTableView.dataSource = self
        myHomeeTableView.delegate = self
        
        //        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        //        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        //
        //        addSubjactButton.frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
        //        addSubjactButton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        //        addSubjactButton.setImage(largeBoldPost, for: .normal)
        //        addSubjactButton.setRounded()
        
        // addSubjactButton.layer.cornerRadius = addSubjactButton.frame.width/2
        
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        myHomeeTableView.addSubview(refreshControl)
        
        
        
        getData()
        
        hideKeyboardWhenTappedAround()
        
        
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //isEmpty()
    //    }
    
    //    func configureAnimation() {
    //
    //        animationView!.contentMode = .scaleAspectFill
    //        animationView!.frame = CGRect(x: 0, y: 70, width: 400, height: 400)
    //        animationView!.center = view.center
    //        MyView.addSubview(animationView!)
    ////        animationView!.play()
    //        animationView!.loopMode = .loop
    //        animationView!.animationSpeed = 1
    //
    //    }
    //    func isEmpty(){
    //        if arraySubjects.count == 0 {
    //            configureAnimation()
    //            animationView!.play()
    //            animationView!.isHidden = false
    //            myHomeeTableView.backgroundView = MyView
    //            myHomeeTableView.reloadData()
    //
    //        } else {
    //            myHomeeTableView.backgroundView = nil
    ////            animationView!.stop()
    //            animationView!.isHidden = true
    //            myHomeeTableView.reloadData()
    //        }
    //    }
    
    
    
}


extension HomeeViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if arraySubjects.count == 0 {
            
            myHomeeTableView.backgroundView = MyView
            
        }else{
            
            myHomeeTableView.backgroundView = nil

            
        }
        return arraySubjects.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myHomeeTableView.dequeueReusableCell(withIdentifier: "HomeeCellTableViewCell",  for: indexPath) as! HomeeCellTableViewCell
        cell.subjactLable.text = arraySubjects[indexPath.row].name
        cell.hoursLable.text = arraySubjects[indexPath.row].hourse
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextvc = storyboard?.instantiateViewController(withIdentifier: "SubHomeViewController") as! SubHomeViewController
        let cell = myHomeeTableView.cellForRow(at: indexPath) as! HomeeCellTableViewCell
        let subjact = cell.subjactLable.text!
        let Hours = cell.hoursLable.text!
        var temp =  arraySubjects[indexPath.row]
        temp.name = subjact
        temp.hourse = Hours
        nextvc.courseObject = temp
        self.present(nextvc, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let userEmail = Auth.auth().currentUser!.email!
        
        if (editingStyle == .delete) {
            
            db.collection("Course").document("\(userEmail)-\(arraySubjects[indexPath.row].name)").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    let alert = UIAlertController(title: "", message: "تم حذف الماده  \(self.arraySubjects[indexPath.row].name)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "موافق", style: .default ,handler: { action in
                        
                        self.arraySubjects.remove(at: indexPath.row)
                        //self.isEmpty()
                        self.myHomeeTableView.reloadData()
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
}


extension HomeeViewController {
    
    func getData(){
        
        db.collection("Course").whereField("userEmail", isEqualTo: Auth.auth().currentUser!.email!)
            .getDocuments { querySnapshot, error in
                if error == nil {
                    for doc in querySnapshot!.documents {
                        let subjact = doc.get("name")!
                        let hourse = doc.get("credit")!
                        self.arraySubjects.append(course(name: "\(subjact)", hourse: "\(hourse)",absent: []))
                    }
                    
                    // self.isEmpty()
                    self.myHomeeTableView.reloadData()
                    //   self.arraySubjects.reverse()
                } else {
                    print(error!.localizedDescription)
                }
            }
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        
        arraySubjects.removeAll()
        
        refreshControl.endRefreshing()
        
        getData()
        //isEmpty()
        //        myHomeeTableView.reloadData()
    }
}
