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

    @IBOutlet weak var addTaskboutton: UIButton!
    var arrayTask : [Task] = []
    
    @IBOutlet weak var MyTaskTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)
        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)
        
        addTaskboutton.frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
       addTaskboutton.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        addTaskboutton.setImage(largeBoldPost, for: .normal)
        addTaskboutton.setRounded()
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
        return 500
        
    }
    
}

extension TaskkViewController {
    
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
    
    
    @objc func refresh(_ sender: AnyObject) {
       
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
