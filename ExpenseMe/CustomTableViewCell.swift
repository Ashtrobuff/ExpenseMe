//
//  CustomTableViewCell.swift
//  ExpenseMe
//
//  Created by Ashish on 20/12/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var AmountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
