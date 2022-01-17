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
    
    let refreshControl = UIRefreshControl()


    
    @IBOutlet weak var houerLable: UILabel!
    
    
    @IBOutlet weak var subjactLable: UILabel!
    

    
    
    @IBOutlet weak var MyTableViewSubHome: UITableView!
    
    @IBOutlet weak var totalRatio: UILabel!
    
    @IBOutlet weak var openAddApcentOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyTableViewSubHome.dataSource = self
        MyTableViewSubHome.delegate = self
        
        houerLable.text = courseObject!.hourse
        subjactLable.text = courseObject!.name
        
//        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
//           refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
//        MyTableViewSubHome.addSubview(refreshControl)
//
//
        getData()
        
        
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .large)

        let largeBoldPost = UIImage(systemName: "plus.circle.fill", withConfiguration: largeConfig)

        openAddApcentOutlet.frame = CGRect(x: 40, y: 740, width: 60 , height: 60)
        openAddApcentOutlet.tintColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        openAddApcentOutlet.setImage(largeBoldPost, for: .normal)
        openAddApcentOutlet.setRounded()

        
        
    
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        print("\\\\\\\\\\\\\\\\\\\\\\\\\\")
       cal()
        
        
    }
    
    
    @IBAction func addNewAcation(_ sender: Any) {
        
              courseObject?.absent.append(Absence(day: "", dete: "", ratio: 0, total_ratio: 0))

        MyTableViewSubHome.reloadData()

    }
    
    
    @IBAction func openAddApcent(_ sender: Any) {
        
        performSegue(withIdentifier: "SheatAbacentSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let des = segue.destination as? AddSubHomeViewController{
            
            des.courseObject = courseObject
            
            
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
   
    
    
    
    
    
    
    
    
}

extension SubHomeViewController {
    
    
    
    func getData(){
        let userEmail = Auth.auth().currentUser!.email!

        db.collection("Course").document("\(userEmail)-\(courseObject!.name)").collection("Abcents").whereField("userEmail", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { querySnapshot, error in
            if error == nil {
                for doc in querySnapshot!.documents {
                
                    let day = doc.get("day")!
                    let dete = doc.get("dete")!
                    var ratio = Double(doc.get("ratio") as! Substring)!
                    
                    print("day :::", day,
                          "dete :::", dete,
                          "ratio :::", ratio
                    )
                    self.courseObject?.absent.append(Absence(day: "\(day)", dete: "\(dete)", ratio: ratio , total_ratio: 0))

                }


               self.MyTableViewSubHome.reloadData()
            } else {
                print(error!.localizedDescription)
            }
            
            
            
            
            
        }
        
    }


    func cal(){
        let userEmail = Auth.auth().currentUser!.email!

        db.collection("Course").document("\(userEmail)-\(courseObject!.name)").collection("Abcents").whereField("userEmail", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { querySnapshot, error in
            if error == nil {
                for doc in querySnapshot!.documents {
                
                    var x = Double (self.houerLable.text!)!

                    var ratio = Double(doc.get("ratio") as! Substring)!

                    print("ratioooooooo :::", ratio, "hourrrrr", x)
                   
            
                                var y = ratio / x * 14
                                 print(y)


                                var d = 0.0
                                d += 25 - y
                            print("mmm : ",d)



                         self.totalRatio.text! = "\(d)"
    
                    
    }
    
    
}
        
        }
    }
    
//    @objc func refresh(_ sender: AnyObject) {
////        arraySubjects.removeAll()
//      getData()
//        refreshControl.endRefreshing()
//    }
//
    
    
    
        
}

