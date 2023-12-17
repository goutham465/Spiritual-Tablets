//
//  ProfileUpdateVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 18/05/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class ProfileUpdateVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var userStatusTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    var emailId = ""
    var fullName = ""
    var phoneNumber = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        
        nameTxt.layer.cornerRadius = 2
        nameTxt.layer.borderWidth = 1
        
        dobTxt.layer.cornerRadius = 2
        dobTxt.layer.borderWidth = 1
        
        userStatusTxt.layer.cornerRadius = 2
        userStatusTxt.layer.borderWidth = 1
        
        mobileNumberTxt.layer.cornerRadius = 2
        mobileNumberTxt.layer.borderWidth = 1
        
        cityTxt.layer.cornerRadius = 2
        cityTxt.layer.borderWidth = 1
        
        countryTxt.layer.cornerRadius = 2
        countryTxt.layer.borderWidth = 1
        
        stateTxt.layer.cornerRadius = 2
        stateTxt.layer.borderWidth = 1
        hideKeyboardWhenTappedAround()
        let loginBy = UserDefaults.standard.string(forKey: "login_by")
        if loginBy != nil && loginBy == "PHONE" {
            self.mobileNumberTxt.isHidden = false
            self.mobileNumberTxt.text = isNil(assignValue: UserDefaults.standard.string(forKey: "userLoginMobile"))
            self.emailTxt.isHidden = true
        } else if loginBy != nil && loginBy == "APPLE"{
            self.emailTxt.isHidden = false
            self.emailTxt.text = isNil(assignValue: emailId)
            self.nameTxt.text = isNil(assignValue: fullName)
            self.mobileNumberTxt.isHidden = true
        } else {
            self.emailTxt.isHidden = false
            self.emailTxt.text = isNil(assignValue: UserDefaults.standard.string(forKey: "userLoginEmail"))
            self.nameTxt.text = isNil(assignValue: fullName)
            self.mobileNumberTxt.isHidden = true
        }
    }
    @IBAction func submitProfileUpdate(_ sender: UIButton) {
        guard isValidData() else {
            return
        }
        submitRegistration()
    }
    func submitRegistration() {
        let ref = Database.database().reference()
        print(ref)
        ref.child("users").childByAutoId().setValue(["city": cityTxt.text!, "profile_status": userStatusTxt.text!, "full_name": nameTxt.text!, "mobile_no": mobileNumberTxt.text, "country": countryTxt.text!, "state": stateTxt.text!, "date_of_birth": dobTxt.text!]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Error:\(error)")
                //error
            } else {
                self.view.makeToast("Profile Updated Successfully", duration: 3.0, position: .bottom)
            }
        }
    }
    private func isValidData() -> Bool {
        if nameTxt.text!.isEmpty {
            self.view.makeToast("Please enter name", duration: 3.0, position: .bottom)
            return false
        } else if userStatusTxt.text!.isEmpty {
            self.view.makeToast("Please enter status", duration: 3.0, position: .bottom)
            return false
        }
        return true
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
func isNil(assignValue: String?) -> String {
    if assignValue != nil {
        return assignValue!
    } else {
        return ""
    }
}
