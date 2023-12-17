//
//  EventsTblCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/06/23.
//

import UIKit

class EventsTblCell: UITableViewCell {

    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventTiming: UILabel!
    @IBOutlet weak var viewBorder: UIView!
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
