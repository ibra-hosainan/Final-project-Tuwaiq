//
//  GPATableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 14/01/2022.
//

import UIKit


class GPATableViewCell: UITableViewCell,UITextFieldDelegate {

    var index : Int = 0
    var gpaDelegate: GPADelegate?
    //var dlgeat : cal?

    @IBOutlet weak var subjactNameTextFiled: UITextField!
    @IBOutlet weak var hoursTextFiled: UITextField!
    @IBOutlet weak var greadTextFiled: UITextField!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        subjactNameTextFiled.delegate = self
        hoursTextFiled.delegate = self
        greadTextFiled.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        subjactNameTextFiled.resignFirstResponder()
        hoursTextFiled.resignFirstResponder()
        greadTextFiled.resignFirstResponder()

        return true
    }
    
    func textFieldDidBeginEditing(_ textFiedld: UITextField) {
//        updateFields()
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateFields()

    }
    
    
    
    func updateFields() {
    
        print(subjactNameTextFiled.text)
        print(hoursTextFiled.text)
        print(greadTextFiled.text)
        
        gpaDelegate?.clculite(index: index, subjactName: subjactNameTextFiled.text ?? "", hours: Int(hoursTextFiled.text ?? "0" ) ?? 0 , gread: Int(greadTextFiled.text ?? "0") ?? 0)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

protocol GPADelegate  {

    func clculite(index : Int ,subjactName : String , hours : Int , gread : Int)
}


@objc protocol TableViewDelegate: NSObjectProtocol{

    func afterClickingReturnInTextField(cell: GPATableViewCell)
}
