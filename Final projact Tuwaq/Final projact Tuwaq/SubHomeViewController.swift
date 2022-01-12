//
//  SubHomeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 04/01/2022.
//

import UIKit
import Firebase

class SubHomeViewController: UIViewController{
    
    var courseObject : course? = nil
    
    let db = Firestore.firestore()
    
    let datePicker = UIDatePicker()

    var selectedDate : String?

    
    @IBOutlet weak var houerLable: UILabel!
    
    
    
    @IBOutlet weak var subjactLable: UILabel!
    

    @IBOutlet weak var AddDete: UIButton!
    
    
    @IBOutlet weak var MyTableViewSubHome: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyTableViewSubHome.dataSource = self
        MyTableViewSubHome.delegate = self
        
        houerLable.text = courseObject!.hourse
        subjactLable.text = courseObject!.name
        //getData()
        
      //  AddDete.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        print(courseObject!.name)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
     //getData()
    }
    
    
    @IBAction func addNewAcation(_ sender: Any) {
        
              courseObject?.absent.append(Absence(day: "", dete: "", ratio: 0, total_ratio: 0))

        MyTableViewSubHome.reloadData()

    }
    

}


extension SubHomeViewController :UITableViewDataSource, UITableViewDelegate  {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return arrayAbsence.count
        
        return courseObject?.absent.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableViewSubHome.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SubHomeTableViewCell
        

        cell.dayLabel.text = courseObject?.absent[indexPath.row].day
        cell.detaLabel.text = courseObject?.absent[indexPath.row].dete
        cell.ratiooLabel.text = "\(courseObject!.absent[indexPath.row].ratio)"
      
        cell.courseObject = courseObject
        
        
        return cell
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}

extension SubHomeViewController {
    
    
    
    func getData(){
        let userEmail = Auth.auth().currentUser!.email!

        db.collection("Course").document("\(userEmail)-\(courseObject!.name)").collection("Abcents").getDocuments { querySnapshot, error in
            if error == nil {
                for doc in querySnapshot!.documents {
                
                    let day = doc.get("day")!
                    let dete = doc.get("dete")!
                    let ratio = doc.get("ratio")!
                    
                    print("///////////////",day,dete,ratio)
                    self.courseObject?.absent.append(Absence(day: "\(day)", dete: "\(dete)", ratio: 40 , total_ratio: 0))
//
                   // print(".........",self.courseObject?.absent)
                    
                }


               self.MyTableViewSubHome.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
        
    }


    
    
}


