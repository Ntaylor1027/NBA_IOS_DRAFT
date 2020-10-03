//
//  PlayerTableViewCell.swift
//  NBA-Stats-Teams
//
//  Created by Noah Taylor on 4/28/20.
//  Copyright © 2020 Noah Taylor. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    // MARK: UI COMPONENTS
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
