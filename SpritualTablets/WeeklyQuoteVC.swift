//
//  WeeklyQuoteVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 01/08/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class WeeklyQuoteVC: UIViewController {
    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var labelStr: UILabel!
    var weekQuoteText = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        Database.database().reference().child("Weekly Quote").observe(.childAdded) { (snapshot) in
            print("UserDataaaFound:\(snapshot.value! as Any)")
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else { return }
            if key == self.getCurrentShortDate() {
                if let details = value["Title"] as? String {
                    self.labelStr.text = details
                }
            }
        }
    }
  
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getCurrentShortDate() -> String {
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let DateInFormat = dateFormatter.string(from: todaysDate)
        return DateInFormat
    }

}
