//
//  AboutUsFounderVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 26/07/23.
//

import UIKit

class AboutUsFounderVC: UIViewController {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var labelStr: UILabel!
    @IBOutlet weak var founderLblStr: UILabel!
    @IBOutlet weak var founderImage: UIImageView!
    @IBOutlet weak var scrolheightConstraint: NSLayoutConstraint!
    var isComingAbout = ""
    var contactDetailsStr = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        if isComingAbout == AboutUs.founder {
            labelStr.text = isComingAbout
            contactDetailsStr = "Dr. Gopala Krishna is a Medical Doctor from India who has 10 years of clinical experience and worked as DMO in Neuro Surgery, Pediatric and General Medicine department. He also has private practice in rural areas and worked as Medical Officer for Jarawa tribes in Andaman Islands.\n\n“Dr. Gopala Krishna” is also a spiritual scientist. He is an enlightened yogi, mystic and visionary who have dedicated himself to the elevation of the physical, mental, and spiritual well-being of people. He has shown a path for the people to attain natural joy and to live life with experience from their own inner nature through Pyramid power and Spiritual Tablets. His scientific approach towards spirituality and work towards the uplift of the humanity have received accolades in southern India, Malaysia, Singapore, Andaman, US & UK. Spiritual Tablets are the most profound, with greater intensity from his deep understanding and wisdom which can change the very core of the being.\n\nBelonging to no particular religion or tradition, “Spiritual Tablets” incorporates the modern person to the spiritual sciences. Spiritual Tablets, are the out pouring of his blissfulness, finds expression in the form of ceaseless offering to all beings. His life and Spiritual Tablets are invitation to connect with the divinity within us through individual transformation and welcomes the silent revolution of self realization."
            self.founderLblStr.text = self.contactDetailsStr
            let labelSize = self.founderLblStr.getSize(constrainedWidth:self.founderLblStr.frame.size.width)
           // self.scrolheightConstraint.constant = labelSize.height + 150.0
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
  

}
