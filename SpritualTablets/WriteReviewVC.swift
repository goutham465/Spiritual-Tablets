//
//  WriteReviewVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/06/23.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import Toast_Swift
@IBDesignable

class WriteReviewVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var fulNameTxt: UITextField!
    @IBOutlet weak var reviewBtn: UIButton!
    @IBOutlet weak var comentsTxt: UITextField!
    @IBOutlet weak var ratingView: CosmosView!
    var admissionName = ""
    var ratingValue = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        ratingView.didTouchCosmos = didTouchCosmos
        ratingView.didFinishTouchingCosmos = didFinishTouchingCosmos
        updateRating(requiredRating: nil)
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func reviewBtnAction(_ sender: UIButton) {
//        ratingView.didTouchCosmos = didTouchCosmos
//        ratingView.didFinishTouchingCosmos = didFinishTouchingCosmos
    }
    
    @IBAction func submitReviewBtnAction(_ sender: UIButton) {
        
        guard isValidData() else {
            return
        }
        submitReviewAction()
    }
    private func isValidData() -> Bool {
        if self.ratingView.rating.isZero {
            self.view.makeToast("You need to give at least one star", duration: 3.0, position: .center)
            return false
        }
        return true
    }
    func submitReviewAction() {
        let ref = Database.database().reference()
        print(ref)
        ref.child("Admission Centers").child(self.admissionName).child("Reviews").childByAutoId().setValue(["name": fulNameTxt.text ?? "", "stars": ratingValue, "user_id": "", "comments": comentsTxt.text ?? ""]) {
            (error:Error?, ref:DatabaseReference) in
            if let error = error {
                print("Error:\(error)")
                //error
            } else {
                self.view.makeToast("Review Submitted Successfully", duration: 3.0, position: .center)
            }
        }
    }
    private func didTouchCosmos(_ rating: Double) {
     // ratingSlider.value = Float(rating)
      updateRating(requiredRating: rating)
      ratingValue = WriteReviewVC.formatValue(rating)
    //  ratingLabel.textColor = UIColor(red: 133/255, green: 116/255, blue: 154/255, alpha: 1)
    }
    
    private func didFinishTouchingCosmos(_ rating: Double) {
     // ratingSlider.value = Float(rating)
      ratingValue = WriteReviewVC.formatValue(rating)
     // ratingLabel.textColor = UIColor(red: 183/255, green: 186/255, blue: 204/255, alpha: 1)
    }
    private class func formatValue(_ value: Double) -> String {
      return String(format: "%.2f", value)
    }
    private func updateRating(requiredRating: Double?) {
        var newRatingValue: Double = 0
        
        if let nonEmptyRequiredRating = requiredRating {
            newRatingValue = nonEmptyRequiredRating
        }
        ratingView.rating = newRatingValue
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
