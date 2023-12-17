//
//  CounsellingRequestVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 02/07/23.
//

import UIKit

class CounsellingRequestVC: UIViewController {

    @IBOutlet weak var musicBorderView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
