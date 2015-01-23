//
//  TaskCell.swift
//  TaskIt
//
//  Created by Carlos Beltran on 12/19/14.
//  Copyright (c) 2014 Carlos. All rights reserved.
//

import UIKit

// We name each Task a TaskCell withing our table view. It inherits from UITableViewCell, giving  us access to its
// awakeFromNib() function and its setSelected function.

class TaskCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
