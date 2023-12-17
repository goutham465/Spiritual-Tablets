//
//  ReviewsTblCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/06/23.
//

import UIKit

class ReviewsTblCell: UITableViewCell {
   // @IBOutlet weak var heigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblComments: UILabel!
    @IBOutlet weak var viewBorder: UIView!
    @IBOutlet weak var dateLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
