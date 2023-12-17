//
//  AdmissionsTblCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 08/06/23.
//

import UIKit

class AdmissionsTblCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var viewBorder: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
