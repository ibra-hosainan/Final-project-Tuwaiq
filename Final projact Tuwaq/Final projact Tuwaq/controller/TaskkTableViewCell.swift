//
//  TaskkTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 10/01/2022.
//

import UIKit

class TaskkTableViewCell: UITableViewCell {
    
    @IBOutlet weak var subjactLable: UILabel!
    @IBOutlet weak var deteLable: UILabel!
    @IBOutlet weak var descrabtionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
