//
//  ResultTableViewCell.swift
//  GolfTrainer
//
//  Created by Asad on 21/11/2020.
//  Copyright © 2020 Asad. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet var clubsLabel: UILabel!

    @IBOutlet var shotsLabel: UITextField!
    @IBOutlet var accurateLabel: UITextField!
    @IBOutlet var leftLabel: UITextField!
    @IBOutlet var shortLeftLabel: UITextField!
    @IBOutlet var shortAccurateLabel: UITextField!
    @IBOutlet var rightLabel: UITextField!

    @IBOutlet var shortRightLabel: UITextField!

    @IBOutlet var deleteResultButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
