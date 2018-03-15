//
//  UserTableCell.swift
//  CoreDataSample
//
//  Created by Sharvan Kumawat on 14/03/18.
//  Copyright © 2018 Sharvan Kumawat. All rights reserved.
//

import UIKit

class UserTableCell: UITableViewCell {
    
    @IBOutlet var lblUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
