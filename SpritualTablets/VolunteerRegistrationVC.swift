//
//  VolunteerRegistrationVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 22/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import Toast_Swift
import IQKeyboardManagerSwift

class VolunteerRegistrationVC: UIViewController, TblCellClassDelegate, UITextFieldDelegate {
    
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
   // @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var scrolContentHeight: NSLayoutConstraint!
    @IBOutlet weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet var volunteerTblView1: UITableView!
    @IBOutlet var volunteerTblView2: UITableView!
    
    var cellIndexPath = IndexPath()
    var contributeDataArray = ["Admin works", "Creating flyers", "Any digital works", "Social media", "Event Management", "Taking meditation classes", "Counselling", "Others"]
    var hourDataArray = ["1 hour a day", "1 hour a week", "1 hour a month", "10 minutes a week", "Others"]
    var daysDataArray = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var daysAppendTxt = [String]()
    var contributeSelected = false
    var timeContributeSelected = false
    var contrinuteStr: String?
    var timeContributeStr: String?
    var selectedIndex: Int?
    var isChecked: Bool = true
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
                            // }
        hideKeyboardWhenTappedAround()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enabledDistanceHandlingClasses.append(VolunteerRegistrationVC.self)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func submitRegistration(_ sender: UIButton) {
        guard isValidData() else {
            return
        }
        if isChecked {
            submitRegistration()
        } else {
            self.view.makeToast("Registration Already Exists", duration: 3.0, position: .center)
        }
    }
    func submitRegistration() {
        spinnerCreation(view: self.view, isStart: true)
        let ref = Database.database().reference()
        print(ref)
        ref.child("volunteer_registration").childByAutoId().setValue(["address": adressTxt.text!, "mail_id": emailtxt.text!, "name": nameTxt.text!, "phone": mobileNumberTxt.text!, "time_to_communicate": contactTxt.text!, "comment": commentsTxt.text ?? "", "submitted_time": "", "time_to_contribute": timeContributeStr!, "way_of_contribution": contrinuteStr!, "work": "", "days": ""]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                spinnerCreation(view: self.view, isStart: false)
                print("Error:\(error)")
                //error
            } else {
                //do stuff
                spinnerCreation(view: self.view, isStart: false)
                self.isChecked = false
                self.view.makeToast("Registration Done Successfully", duration: 3.0, position: .center)
            }
        }
    }
    private func isValidData() -> Bool {
        if nameTxt.text!.isEmpty {
            self.view.makeToast("Please enter name", duration: 3.0, position: .bottom)
            return false
        } else if adressTxt.text!.isEmpty {
            self.view.makeToast("Please enter address", duration: 3.0, position: .bottom)
            return false
        } else if mobileNumberTxt.text!.isEmpty {
            self.view.makeToast("Please enter Phone number", duration: 3.0, position: .bottom)
            return false
        } else if contrinuteStr == "" {
            self.view.makeToast("Please select any field", duration: 3.0, position: .bottom)
            return false
        } else if timeContributeStr == "" {
            self.view.makeToast("Please select any time field", duration: 3.0, position: .bottom)
            return false
        } else if contactTxt.text!.isEmpty {
            self.view.makeToast("Please enter time", duration: 3.0, position: .bottom)
            return false
        }
        return true
    }
        
    func checkBoxCellTaped(cell: AnswerCheckboxCell) {
        cellIndexPath = self.volunteerTblView2.indexPath(for: cell)!
        print("CheckBox tapped on row \(cellIndexPath.row)")
    }
    func radioCellTapped(cell: AnswerRadioCell) {
        cellIndexPath = self.volunteerTblView.indexPath(for: cell)!
        print("RadioCell tapped on row \(cellIndexPath.row)")
        let data = contributeDataArray[cellIndexPath.row]
        cell.lblAnswer1.text = data
        print(cell.lblAnswer1.text!)
        self.contrinuteStr = cell.lblAnswer1.text!
        selectedIndex = cellIndexPath.row
        self.volunteerTblView.reloadData()
    }
    func radioCellTapped11(cell: AnswerRadioCell11) {
        cellIndexPath = self.volunteerTblView1.indexPath(for: cell)!
        print("RadioCell11 tapped on row \(cellIndexPath.row)")
        let data = hourDataArray[cellIndexPath.row]
        cell.lblAnswer2.text = data
        print(cell.lblAnswer2.text!)
        self.timeContributeStr = cell.lblAnswer2.text!
        selectedIndex = cellIndexPath.row
        self.volunteerTblView1.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
        if tableView == volunteerTblView {
            if let radioCell = volunteerTblView.dequeueReusableCell(withIdentifier: "AnswerRadioCell", for: indexPath)  as? AnswerRadioCell {
                radioCell.delegate = self
                radioCell.radioBtn.tag = indexPath.row
                let data = contributeDataArray[indexPath.row]
                radioCell.lblAnswer1.text = data
                if selectedIndex == indexPath.row {
                    radioCell.radioBtn.setImage(UIImage(named: "radio_on"), for: .normal)
                } else {
                    radioCell.radioBtn.setImage(UIImage(named: "radio_off"), for: .normal)
                }
                
                return radioCell
            }
            
        } else if tableView == volunteerTblView1 {
            if let radioCell = volunteerTblView1.dequeueReusableCell(withIdentifier: "AnswerRadioCell11", for: indexPath)  as? AnswerRadioCell11 {
                radioCell.delegate = self
                radioCell.radioBtn.tag = indexPath.row
                let data = hourDataArray[indexPath.row]
                radioCell.lblAnswer2.text = data
                if selectedIndex == indexPath.row {
                    radioCell.radioBtn.setImage(UIImage(named: "radio_on"), for: .normal)
                } else {
                    radioCell.radioBtn.setImage(UIImage(named: "radio_off"), for: .normal)
                }
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
