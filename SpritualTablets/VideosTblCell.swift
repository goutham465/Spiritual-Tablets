//
//  VideosTblCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 22/06/23.
//

import UIKit

class VideosTblCell: UITableViewCell {
    @IBOutlet weak var lblContentName: UILabel!
    @IBOutlet weak var btnContentLink: UIButton!
    @IBOutlet weak var lblVideoDate: UILabel!
    @IBOutlet weak var heigthConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
