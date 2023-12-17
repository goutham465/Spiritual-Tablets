//
//  WriteReviewVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/06/23.
//

import UIKit
import Foundation
@IBDesignable

class WriteReviewVC: UIViewController {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var fulNameTxt: UITextField!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var comentsTxt: UITextField!
    @IBOutlet weak var ratingView: CosmosView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitReviewBtnAction(_ sender: UIButton) {
        
        
    }

}

class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 3
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var shadowColor: UIColor? = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    @IBInspectable var shadowOpacity: Float = 0.3
    @IBInspectable var shadowRadius: Float = 4
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}
