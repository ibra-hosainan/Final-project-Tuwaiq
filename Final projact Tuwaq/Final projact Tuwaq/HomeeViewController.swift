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
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
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
        
       // data(subject: subjact!, hourse: Hours!)

       


        self.present(nextvc, animated: true, completion: nil)

    

}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func getData(){
        db.collection("Course")
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
