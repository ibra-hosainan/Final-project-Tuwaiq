//
//  TaskkViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 10/01/2022.
//

import UIKit
import Firebase

class TaskkViewController: UIViewController {
    
    let db = Firestore.firestore()
    let refreshControl = UIRefreshControl()
    var arrayTask : [Task] = []
    
    @IBOutlet weak var addTaskboutton: UIButton!
    @IBOutlet weak var MyTaskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        //        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        
        //        addTaskboutton.frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
        //       addTaskboutton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        //        addTaskboutton.setImage(largeBoldPost, for: .normal)
        //        addTaskboutton.setRounded()
        MyTaskTableView.dataSource = self
        MyTaskTableView.delegate = self
        
        getData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        MyTaskTableView.addSubview(refreshControl)
    }
    
    
    
    
}

extension TaskkViewController : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        arrayTask.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyTaskTableView.dequeueReusableCell(withIdentifier: "TaskkTableViewCell", for: indexPath) as! TaskkTableViewCell
        
        cell.subjactLable.text = arrayTask[indexPath.row].subjact
        cell.deteLable.text = arrayTask[indexPath.row].dete
        cell.descrabtionLable.text = arrayTask[indexPath.row].descrabtion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let userEmail = Auth.auth().currentUser!.email!
        
        if (editingStyle == .delete) {
            db.collection("Task").document("\(userEmail)-\(arrayTask[indexPath.row].subjact)").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    let alert = UIAlertController(title: "", message: "تم حذف المهمه  \(self.arrayTask[indexPath.row].subjact)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "موافق", style: .default ,handler: { action in
                        
                        self.arrayTask.remove(at: indexPath.row)
                        self.MyTaskTableView.reloadData()
                    })
                    alert.addAction(action)
                    self.present(alert, animated: true)
                    print("Document successfully removed!")
                }
            }
        }
    }
}

extension TaskkViewController {
    
    func getData(){
        db.collection("Task").whereField("userEmail", isEqualTo: Auth.auth().currentUser!.email!)
            .getDocuments { querySnapshot, error in
                if error == nil {
                    for doc in querySnapshot!.documents {
                        let subject = doc.get("subject")!
                        let dete = doc.get("dete")!
                        let descrabtion = doc.get("descrabtion")!
                        
                        self.arrayTask.append(Task(subjact: "\(subject)", dete: "\(dete)", descrabtion:"\(descrabtion)"))
                    }
                    
                    
                    self.MyTaskTableView.reloadData()
                } else {
                    print(error!.localizedDescription)
                }
            }
    }
    
    
    @objc func refresh(_ sender: AnyObject) {
        arrayTask.removeAll()
        getData()
        refreshControl.endRefreshing()
    }
    
    
}


extension UIButton {
    
    func setRounded() {
        
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.masksToBounds = true
    }
}
