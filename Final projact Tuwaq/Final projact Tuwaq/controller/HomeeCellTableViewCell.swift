//
//  HomeeCellTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 11/01/2022.
//

import UIKit

class HomeeCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var hoursLable: UILabel!
    @IBOutlet weak var subjactLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
