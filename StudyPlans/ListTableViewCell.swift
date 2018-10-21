//
//  ListTableViewCell.swift
//  StudyPlans
//
//  Created by 牧野晴音 on 2018/07/01.
//  Copyright © 2018年 牧野晴音. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet var subjectLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
