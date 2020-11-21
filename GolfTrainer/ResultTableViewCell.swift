//
//  ResultTableViewCell.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet weak var clubsLabel: UILabel!
    
    @IBOutlet weak var shotsLabel: UITextField!
    @IBOutlet weak var accurateLabel: UITextField!
    @IBOutlet weak var leftLabel: UITextField!
    @IBOutlet weak var shortLeftLabel: UITextField!
    @IBOutlet weak var shortAccurateLabel: UITextField!
    @IBOutlet weak var rightLabel: UITextField!
    
    @IBOutlet weak var shortRightLabel: UITextField!
    
    @IBOutlet weak var deleteResultButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
