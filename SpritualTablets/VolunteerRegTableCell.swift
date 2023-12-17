//
//  VolunteerRegTableCell.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 23/06/23.
//

import Foundation
import UIKit

// Protocol for Questionariess
protocol TblCellClassDelegate: AnyObject {
    func radioCellTapped(cell: AnswerRadioCell)
    func checkBoxCellTaped(cell: AnswerCheckboxCell)
    func radioCellTapped11(cell: AnswerRadioCell11)
}

class AnswerCheckboxCell: UITableViewCell {
    weak var delegate: TblCellClassDelegate?
    @IBOutlet weak var checkBox: CheckBox!
    @IBOutlet weak var lblAnswer2: UILabel!

    @IBAction func checkBoxClicked(_ sender: CheckBox) {
        self.delegate?.checkBoxCellTaped(cell: self)
    }
}

class AnswerRadioCell: UITableViewCell {
    weak var delegate: TblCellClassDelegate?
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var lblAnswer1: UILabel!

    @IBAction func radioBtnClicked(_ sender: UIButton) {
        self.delegate?.radioCellTapped(cell: self)
    }
}

class AnswerRadioCell11: UITableViewCell {
    weak var delegate: TblCellClassDelegate?
    @IBOutlet weak var radioBtn: UIButton!
    @IBOutlet weak var lblAnswer2: UILabel!

    @IBAction func radioBtnClicked(_ sender: UIButton){
        self.delegate?.radioCellTapped11(cell: self)
    }
}
class CheckBox: UIButton {
    // Images
    let checkedImage = UIImage(named: "checkbox_filled icon")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox_unfilled icon")! as UIImage
   
    // Bool property
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                self.setImage(checkedImage, for: UIControl.State.normal)
            } else {
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
        }
    }
}
