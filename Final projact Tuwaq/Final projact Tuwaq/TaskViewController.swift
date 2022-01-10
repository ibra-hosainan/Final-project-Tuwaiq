//
//  TaskViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 09/01/2022.
//

import UIKit
import Firebase

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let db = Firestore.firestore()

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayTask.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTaskTableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        cell.subjactTextFiled.text = arrayTask[indexPath.row].subjact
        cell.DeteTextFiled.text = arrayTask[indexPath.row].dete
        cell.DescrabtionTextFiled.text = arrayTask[indexPath.row].descrabtion
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
        
    }
    
    
   
    
    func getData(){
        db.collection("Task")
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
    
    
    
    var arrayTask : [Task] = []
    
    @IBOutlet weak var MyTaskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyTaskTableView.delegate = self
        MyTaskTableView.dataSource = self
        getData()
        
        
    }
    
    @IBAction func NewTaskAcation(_ sender: Any) {
        
//        if arrayTask.isEmpty {
//
//            arrayTask.append(Task(subjact: "", dete: "", descrabtion: ""))
//            
//            MyTaskTableView.reloadData()
//
//        }
        arrayTask.append(Task(subjact: "", dete: "", descrabtion: ""))
        
        MyTaskTableView.reloadData()
        
    }
}
