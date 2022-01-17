//
//  HomeeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 11/01/2022.
//

import UIKit
import Firebase

class HomeeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var addSubjactButton: UIButton!
    
    let db = Firestore.firestore()

    let refreshControl = UIRefreshControl()


    @IBOutlet weak var myHomeeTableView: UITableView!
    
    var arr : course?
    
    var arraySubjects : [course] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        myHomeeTableView.dataSource = self
        myHomeeTableView.delegate = self
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)

        addSubjactButton.frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
        addSubjactButton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        addSubjactButton.setImage(largeBoldPost, for: .normal)
        addSubjactButton.setRounded()


       // addSubjactButton.layer.cornerRadius = addSubjactButton.frame.width/2

       
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
           myHomeeTableView.addSubview(refreshControl)
        
        
     
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
       print("temp : ",temp)
   

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
    
    func getData(){
        db.collection("Course").whereField("userEmail", isEqualTo: Auth.auth().currentUser!.email!)
            .getDocuments { querySnapshot, error in
                if error == nil {
                    for doc in querySnapshot!.documents {
                        let subjact = doc.get("name")!
                        let hourse = doc.get("credit")!
                        self.arraySubjects.append(course(name: "\(subjact)", hourse: "\(hourse)",absent: []))
                    }
                
                    
                    self.myHomeeTableView.reloadData()
                 //   self.arraySubjects.reverse()
                } else {
                    print(error!.localizedDescription)
                }
            }
    }
    @objc func refresh(_ sender: AnyObject) {
        arraySubjects.removeAll()
      getData()
        refreshControl.endRefreshing()
    }

}
    
   



    
    

