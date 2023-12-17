//
//  ProgressDialog.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 09/06/23.
//

import Foundation
import UIKit

var activityIndicator = UIActivityIndicatorView()
var myView: UIView = UIView()

func spinnerCreation(view: UIView, isStart: Bool) {
    
    if isStart {
        activityIndicator.style =  .whiteLarge
        let label = UILabel.init(frame: CGRect(x: 5, y: 60, width: 90, height: 20))
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        label.textAlignment = NSTextAlignment.center
        label.text = "Please wait...."
        
        myView.frame = CGRect(x: (UIScreen.main.bounds.size.width - 100)/2, y: (UIScreen.main.bounds.size.height - 100)/2, width: 100, height: 100)
        
        myView.backgroundColor = UIColor.init(white: 0.0, alpha: 0.7)
        myView.layer.cornerRadius = 5
        activityIndicator.center = CGPoint(x: myView.frame.size.width/2, y: myView.frame.size.height/2 - 10)
        myView.addSubview(activityIndicator)
        myView.addSubview(label)
        view.addSubview(myView)
        myView.isHidden = false
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        view.bringSubviewToFront(myView)
    } else {
        view.isUserInteractionEnabled = true
        myView.removeFromSuperview()
    }
}

