//
//  CategoryCells.swift
//  iQuiz
//
//  Created by iGuest on 5/5/16.
//  Copyright © 2016 Brittney. All rights reserved.
//

import UIKit

class CategoryCells: UITableViewCell {

    @IBOutlet var photo: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var describe: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
