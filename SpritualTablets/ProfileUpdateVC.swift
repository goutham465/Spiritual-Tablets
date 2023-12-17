//
//  ProfileUpdateVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 18/05/23.
//

import UIKit

class ProfileUpdateVC: UIViewController {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var userStatusTxt: UITextField!
    @IBOutlet weak var dobTxt: UITextField!
    @IBOutlet weak var countryTxt: UITextField!
    @IBOutlet weak var stateTxt: UITextField!
    @IBOutlet weak var cityTxt: UITextField!
    @IBOutlet weak var mobileNumberTxt: UITextField!
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
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
