//
//  GPAViewController.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 14/01/2022.
//

import UIKit

class GPAViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewDelegate , GPADelegate{
    
    
    func clculite(index: Int, subjactName: String, hours: Int, gread: Int) {
        arrayGrade[index].subjactName = subjactName
        arrayGrade[index].hours = hours
        arrayGrade[index].grade = gread
        print(arrayGrade)
        MyGpaTableView.reloadData()
        
    }
    
    
    var valueToPass : String = ""
    var valueToPass2 : Int = 0
    var valueToPass3 : Int = 0

    //var x = Double (self.houerLable.text!)!

    func afterClickingReturnInTextField(cell: GPATableViewCell) {
        valueToPass = cell.subjactNameTextFiled.text!
        valueToPass2 = Int(cell.greadTextFiled.text!)!
        valueToPass3 = Int(cell.hoursTextFiled.text!)!
    }
    
//    func clculite(_ GpaCell: GPATableViewCell, addNumber: Int) {
//        let x =  Int(GpaCell.greadTextFiled.text!)!
//        var y = Int(GpaCell.hoursTextFiled.text!)!
//        var z = GpaCell.subjactNameTextFiled.text!
//        arrayGrade.append(Grade(subjactName: z, hours: y, grade: x))
//        calculatGPA()
//    }
//
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("subjact : ", valueToPass!)
//        print("gread : ", valueToPass2!)
//        print("hours : ", valueToPass3!)
//
//
//    }

    @IBOutlet weak var MyGpaTableView: UITableView!
    
    var x = 0
    var y = 0
    var arrayGrade : [Grade] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MyGpaTableView.dataSource = self
        MyGpaTableView.delegate = self
        hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
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
        //cell.tableViewDelegate = (self as TableViewDelegate)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
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
       print(GPA)
       
       

    }
    
   
    @IBAction func AddNewSubjact(_ sender: Any) {
        
    
        
        arrayGrade.append(Grade(subjactName: "", hours: 0, grade: 0))
        MyGpaTableView.reloadData()
        
    }
    
    @IBAction func calculatGPAButton(_ sender: Any) {
        
      calculatGPA()
//
//        print("result :",calculatGPA())
        
        
    }
    

}
