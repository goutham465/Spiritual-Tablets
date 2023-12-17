//
//  VolunteerRegistrationVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 22/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class VolunteerRegistrationVC: UIViewController, TblCellClassDelegate {
    
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var adressTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var commentsTxt: UITextField!
    @IBOutlet weak var contactTxt: UITextField!
    @IBOutlet var weekDaysTxt: [UIButton]!
    @IBOutlet var timeBaseTxt: [UIButton]!
    @IBOutlet var contributesTxt: [UIButton]!
    @IBOutlet var volunteerTblView: UITableView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var scrolContentHeight: NSLayoutConstraint!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var volunteerTblView1: UITableView!
    @IBOutlet var volunteerTblView2: UITableView!
    
    var cellIndexPath = IndexPath()
    var contributeDataArray = ["Admin works", "Creating flyers", "Any digital works", "Social media", "Event Management", "Taking meditation classes", "Counselling", "Others"]
    var hourDataArray = ["1 hour a day", "1 hour a week", "1 hour a month", "10 minutes a week", "Others"]
    var daysDataArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.volunteerTblView.reloadData()
        self.volunteerTblView.rowHeight = UITableView.automaticDimension
        self.volunteerTblView.estimatedRowHeight = 45
      //  tableviewHeight.constant = volunteerTblView.contentSize.height
       // scrolContentHeight.constant = volunteerTblView.contentSize.height + self.view.frame.size.height
       // scrolView.contentSize = CGSize.init(width: scrolView.contentSize.width, height: volunteerTblView.contentSize.height + self.view.frame.size.height)
        let ref = Database.database().reference()
        print(ref)
        ref.child("volunteer_registration").child("address").setValue("Manikonda"){
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Error:\(error)")
                //error
            } else {
                //do stuff
            }
        }
                              // }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
//    @IBAction func radioBtnClicked(_ sender: UIButton) {
//        if sender.tag == 10 {
//            contributesTxt[0].isSelected = true
//            contributesTxt[1].isSelected = false
//            contributesTxt[2].isSelected = false
//            contributesTxt[3].isSelected = false
//            contributesTxt[4].isSelected = false
//            contributesTxt[5].isSelected = false
//            contributesTxt[6].isSelected = false
//            contributesTxt[7].isSelected = false
//
//            timeBaseTxt[0].isSelected = false
//            timeBaseTxt[1].isSelected = false
//            timeBaseTxt[2].isSelected = false
//            timeBaseTxt[3].isSelected = false
//            timeBaseTxt[4].isSelected = false
//
//            weekDaysTxt[0].isSelected = false
//            weekDaysTxt[1].isSelected = false
//            weekDaysTxt[2].isSelected = false
//            weekDaysTxt[3].isSelected = false
//            weekDaysTxt[4].isSelected = false
//            weekDaysTxt[5].isSelected = false
//            weekDaysTxt[6].isSelected = false
//
//            contributesTxt[0].setImage(UIImage(named: "radio_on"), for: .normal)
//            contributesTxt[1, 2 ,3, 4, 5, 6, 7].setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//
//        } else if sender.tag == 20 {
//            radioBtnRefillCylinder.isSelected = true
//            radioBtnNewCylinder.isSelected = false
//            radioBtnBuyBackCylinder.isSelected = false
//            // radioBtnCash?.isSelected = false
//           // radioBtnHomeDelivery?.isSelected = false
//            radioBtnRefillCylinder.setImage(UIImage(named: "radio_on"), for: .normal)
//            radioBtnNewCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            // radioBtnCash?.setImage(UIImage(named: "radio_off"), for: .normal)
//           // radioBtnHomeDelivery?.setImage(UIImage(named: "radio_off"), for: .normal)
//            self.stackViewCash?.isHidden = false
//            self.stackViewCash?.tag = 0
//        } else if sender.tag == 5 {
//            radioBtnHomeDelivery?.isSelected = true
//            // radioBtnNewCylinder.isSelected = false
//           // radioBtnBuyBackCylinder.isSelected = false
//           // radioBtnRefillCylinder.isSelected = false
//            radioBtnCash?.isSelected = false
//            radioBtnHomeDelivery?.setImage(UIImage(named: "radio_on"), for: .normal)
//           // radioBtnNewCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            // radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnCash?.setImage(UIImage(named: "radio_off"), for: .normal)
//            // radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            self.transactionType = "Home Delivery"
//
//        } else if sender.tag == 6 {
//            radioBtnCash?.isSelected = true
//            // radioBtnNewCylinder.isSelected = false
//           radioBtnHomeDelivery?.isSelected = false
//            // radioBtnBuyBackCylinder.isSelected = false
//            radioBtnCash?.setImage(UIImage(named: "radio_on"), for: .normal)
//            // radioBtnNewCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//           // radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnHomeDelivery?.setImage(UIImage(named: "radio_off"), for: .normal)
//           // radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            self.transactionType = "Cash n Carry"
//        } else {
//            radioBtnBuyBackCylinder.isSelected = true
//            radioBtnNewCylinder.isSelected = false
//            radioBtnRefillCylinder.isSelected = false
//            radioBtnCash?.isSelected = false
//            radioBtnHomeDelivery?.isSelected = false
//            radioBtnBuyBackCylinder.setImage(UIImage(named: "radio_on"), for: .normal)
//            radioBtnNewCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnRefillCylinder.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnCash?.setImage(UIImage(named: "radio_off"), for: .normal)
//            radioBtnHomeDelivery?.setImage(UIImage(named: "radio_off"), for: .normal)
//            self.stackViewCash?.isHidden = true
//
//        }
//        if let delegate = delegate {
//            delegate.radioBtnAction(cell: self, sender: sender)
//        }
//    }
    
    func checkBoxCellTaped(cell: AnswerCheckboxCell) {
        cellIndexPath = self.volunteerTblView2.indexPath(for: cell)!
        print("CheckBox tapped on row \(cellIndexPath.row)")
    }
    func radioCellTapped(cell: AnswerRadioCell) {
        cellIndexPath = self.volunteerTblView.indexPath(for: cell)!
        print("RadioCell tapped on row \(cellIndexPath.row)")
    }
    func radioCellTapped11(cell: AnswerRadioCell11) {
        cellIndexPath = self.volunteerTblView1.indexPath(for: cell)!
        print("RadioCell11 tapped on row \(cellIndexPath.row)")
    }

}

extension VolunteerRegistrationVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if tableView == volunteerTblView {
            return contributeDataArray.count
        } else if tableView == volunteerTblView1 {
            return hourDataArray.count
        } else {
            return daysDataArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if let checkBoxCell = volunteerTblView.dequeueReusableCell(withIdentifier: "AnswerCheckboxCell", for: indexPath)  as? AnswerCheckboxCell {
//
//            return checkBoxCell
//        }
        if tableView == volunteerTblView {
            if let radioCell = volunteerTblView.dequeueReusableCell(withIdentifier: "AnswerRadioCell", for: indexPath)  as? AnswerRadioCell {
                radioCell.delegate = self
                radioCell.radioBtn.tag = indexPath.row
                let data = contributeDataArray[indexPath.row]
                radioCell.lblAnswer1.text = data
                return radioCell
            }
            
        } else if tableView == volunteerTblView1 {
            if let radioCell = volunteerTblView1.dequeueReusableCell(withIdentifier: "AnswerRadioCell11", for: indexPath)  as? AnswerRadioCell11 {
                radioCell.delegate = self
                radioCell.radioBtn.tag = indexPath.row
                let data = hourDataArray[indexPath.row]
                radioCell.lblAnswer2.text = data
                return radioCell
            }
        } else {
            if let radioCell = volunteerTblView2.dequeueReusableCell(withIdentifier: "AnswerCheckboxCell", for: indexPath)  as? AnswerCheckboxCell {
                radioCell.delegate = self
                radioCell.checkBox.tag = indexPath.row
                let data = daysDataArray[indexPath.row]
                radioCell.lblAnswer2.text = data
                return radioCell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45.0
    }
}
enum QuetionType {
    static let radioNotSelected = "Single Select"
    static let checkBoxOff = "Multi Select"
}
