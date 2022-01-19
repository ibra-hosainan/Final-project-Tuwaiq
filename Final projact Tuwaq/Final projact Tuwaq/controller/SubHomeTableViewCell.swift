//
//  SubHomeTableViewCell.swift
//  Final projact Tuwaq
//
//  Created by Abrahim MOHAMMED on 04/01/2022.
//

import UIKit
import Firebase

class SubHomeTableViewCell: UITableViewCell {
    
    
    var courseObject : course? = nil
    let db = Firestore.firestore()
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var detaLabel: UILabel!
    @IBOutlet weak var ratiooLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}
