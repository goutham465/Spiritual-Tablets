//
//  ContactPrimaryCentersVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 26/07/23.
//

import UIKit

class ContactPrimaryCentersVC: UIViewController {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var scrolCardView: UIView!
    @IBOutlet weak var scrolheightConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
       // scrolView.frame
     //   self.scrolCardView.frame = CGRect(x: 0, y: 0, width: 700, height: self.scrolCardView.frame.size.height)
        self.scrolCardView.frame.size.width = 700
        scrolView.showsHorizontalScrollIndicator = true
       // scrolView.contentOffset.x = 0
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
