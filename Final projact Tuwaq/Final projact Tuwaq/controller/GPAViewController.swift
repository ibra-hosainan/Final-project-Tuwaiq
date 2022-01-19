//
//  GPAViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 14/01/2022.
//

import UIKit

class GPAViewController : UIViewController {
    
    var x = 0
    var y = 0
    var arrayGrade : [Grade] = []
    
    @IBOutlet weak var MyGpaTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyGpaTableView.dataSource = self
        MyGpaTableView.delegate = self
        hideKeyboardWhenTappedAround()
        
    }
    
    
    
    @IBAction func AddNewSubjact(_ sender: Any) {
        
        arrayGrade.append(Grade(subjactName: "", hours: 0, grade: 0))
        MyGpaTableView.reloadData()
        
    }
    
    @IBAction func calculatGPAButton(_ sender: Any) {
        
        calculatGPA()
    }
}


extension GPAViewController : GPADelegate {
    
    func clculite(index: Int, subjactName: String, hours: Int, gread: Int) {
        arrayGrade[index].subjactName = subjactName
        arrayGrade[index].hours = hours
        arrayGrade[index].grade = gread
        print(arrayGrade)
        MyGpaTableView.reloadData()
        
    }
    
    func calculatGPA(){
        
        var GPA : Int = 0
        var temp : Int = 0
        var x : Int = 0
        
        arrayGrade.forEach { GpaCours in
            temp += GpaCours.hours * GpaCours.grade
            x += GpaCours.hours
            
        }
        if x == 0 {
            
        }else{
            GPA = temp/x
            
        }
        print("GPA : ",GPA)
    }
}


extension GPAViewController :  UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayGrade.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MyGpaTableView.dequeueReusableCell(withIdentifier: "GPATableViewCell", for: indexPath) as! GPATableViewCell
        cell.subjactNameTextFiled.text = "\(arrayGrade[indexPath.row].subjactName)"
        cell.hoursTextFiled.text = "\( arrayGrade[indexPath.row].hours)"
        cell.greadTextFiled.text =  "\(arrayGrade[indexPath.row].grade)"
        cell.index = indexPath.row
        cell.gpaDelegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
        
    }
}
