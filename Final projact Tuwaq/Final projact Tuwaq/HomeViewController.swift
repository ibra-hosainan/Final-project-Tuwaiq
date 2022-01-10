//
//  HomeViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 02/01/2022.
//

import UIKit
import Firebase
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arraySubjects : [course] = []
    
    let db = Firestore.firestore()

    @IBOutlet weak var MyTableViewHome: UITableView!
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyTableViewHome.delegate = self
        MyTableViewHome.dataSource = self
        getData()

    }
    
    
    @IBAction func NewCellAcation(_ sender: Any)  {


//        arraySubjects.reversed()
//
        
        
        if arraySubjects.isEmpty {

            arraySubjects.append(course(name: "", hourse: "", absent: [Absence(day: "", dete: "", ratio: 0, total_ratio: 0)]))

            MyTableViewHome.reloadData()




        } else{
           // arraySubjects.reversed()
            arraySubjects.removeAll()
                   getData()

            arraySubjects.append(course(name: "", hourse: "", absent: [Absence(day: "", dete: "", ratio: 0, total_ratio: 0)]))

            MyTableViewHome.reloadData()


        }
        
        
    
    

       
    }
    

    @IBAction func updateAcation(_ sender: Any) {
    
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arraySubjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyTableViewHome.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! HomeTableViewCell
        
        cell.subjactTextFiled.text = arraySubjects[indexPath.row].name
        cell.HoursTextFiled.text = arraySubjects[indexPath.row].hourse

       return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextvc = storyboard?.instantiateViewController(withIdentifier: "SubHomeViewController") as! SubHomeViewController
        
        let cell = MyTableViewHome.cellForRow(at: indexPath) as! HomeTableViewCell
        
        
        let subjact = cell.subjactTextFiled.text
        let Hours = cell.HoursTextFiled.text
    
        if subjact! == "" && Hours! == ""{
            
           
            
            let alert = UIAlertController(title: "", message: "ادخل قيمه", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default)
            alert.addAction(action)
            present(alert, animated: true)
        }
        else {
            
        
            
            var temp =  arraySubjects[indexPath.row]
            temp.name = subjact!
            temp.hourse = Hours!
            
          
            
            nextvc.courseObject = temp
            
            data(subject: subjact!, hourse: Hours!)

           


            self.present(nextvc, animated: true, completion: nil)

        }
        
      
       
        
        
        
        
    }
    
    func data(subject : String , hourse  : String){
        
        
        let userEmail = Auth.auth().currentUser!.email!
            
        self.db.collection("Course").document("\(userEmail)-\(subject)").setData(  [
            "userEmail" : "\(Auth.auth().currentUser!.email!)",
            "TotalAlabcents": 0,
            "name" : "\(subject)",
            "credit": hourse,
               
           ])
            { error in
                   if error == nil {
                       print("New document has been created...")
                   } else {
                       print("error\(error!.localizedDescription)")
                   }
                   
               }
        
        
//        db.collection("Course").document("email-subject").collection("Abcents").document().setData([
//
//        //data
//
//        ]) { error in
//
//
//        }
        
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
                
                  
                    self.MyTableViewHome.reloadData()
                } else {
                    print(error!.localizedDescription)
                }
            }
    }
        
    
}
