//
//  WorkShopsEventTypeCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 17/06/23.
//

import UIKit

class WorkShopsEventTypeCell: UITableViewCell {
    
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventTiming: UILabel!
    @IBOutlet weak var btnEventLink: UIButton!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var heigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnImageLink: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
