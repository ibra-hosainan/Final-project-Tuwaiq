//
//  HomeTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 03/01/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

   
    @IBOutlet weak var subjactTextFiled: UITextField!

    
    @IBOutlet weak var HoursTextFiled: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
