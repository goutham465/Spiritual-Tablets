//
//  LanguageAlertView.Swift
//  LanguageAlertView
//
//  Created by Arpit Jain on 13/12/17.
//  Copyright © 2017 Arpit Jain. All rights reserved.
//

import UIKit
import Foundation

class LanguageAlertView: UIViewController {
    
    // MARK: - Private Properties
    // MARK: -

    private var strAlertTitle = "APPLICATION NAME"
    private var strAlertText = String()
    private var btnCancelTitle: String?
    private var btnOtherTitle: String?
    private var btn2Title: String?
    
    private let btnOtherColor  =  ColorConverter.hexStringToUIColor(hex: "F7B245")
    private let btnCancelColor =  ColorConverter.hexStringToUIColor(hex: "F7B245")
    
    // MARK: - Public Properties
    // MARK: -

    @IBOutlet var viewAlert: UIView!
   
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnTelugu: UIButton!
    @IBOutlet weak var btnHindi: UIButton!
    @IBOutlet weak var btnKannada: UIButton!
    @IBOutlet weak var btnMarati: UIButton!
    @IBOutlet weak var btnGujarati: UIButton!
    /// AlertController Completion handler
    typealias AlertCompletionBlock = ((Int, String) -> Void)?
    private var block: AlertCompletionBlock?
    
    private var isDACCode = false
    
    // MARK: - LanguageAlertView Initialization
    // MARK: -
    
    /**
     Creates a instance for using LanguageAlertView
     - returns: LanguageAlertView
     */
    static func initialization() -> LanguageAlertView {
        let alertController = LanguageAlertView(nibName: "LanguageAlertView", bundle: nil)
        return alertController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguageAlertView()
    }
    
    // MARK: - LanguageAlertView Private Functions
    // MARK: -
    
    /// Inital View Setup
    private func setupLanguageAlertView() {
        
        let visualEffectView   = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.alpha = 0.8
        visualEffectView.frame = self.view.bounds
        visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        visualEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundViewTapped)))
        self.view.insertSubview(visualEffectView, at: 0)
        
        preferredAlertWidth()
        
        viewAlert.layer.cornerRadius  = 4.0
        viewAlert.layer.shadowOffset  = CGSize(width: 0.0, height: 0.0)
        viewAlert.layer.shadowColor   = UIColor(white: 0.0, alpha: 1.0).cgColor
        viewAlert.layer.shadowOpacity = 0.3
        viewAlert.layer.shadowRadius  = 3.0

        lblAlertText?.font = UIFont(name: "Roboto-Medium", size: 20.0)
        lblAlertText?.text   = strAlertText
        
        if let aCancelTitle = btnCancelTitle {
            btnCancel.setTitle(aCancelTitle, for: .normal)
            btnCancel.setTitleColor(btnCancelColor, for: .normal)
        } else {
            btnCancel.isHidden  = true
        }
        let setTelugu = NSLocalizedString("Language", comment: "Telugu button")
        btnTelugu.setTitle(setTelugu, for: .normal)
        
        let setHindi = NSLocalizedString("Language", comment: "Hindi button")
        btnHindi.setTitle(setHindi, for: .normal)
        
        let setKannada = NSLocalizedString("Language", comment: "Kanada button")
        btnKannada.setTitle(setKannada, for: .normal)
        
        let setMarati = NSLocalizedString("Language", comment: "marati button")
        btnMarati.setTitle(setMarati, for: .normal)
        
        let setGujarati = NSLocalizedString("Language", comment: "Gujart button")
        btnGujarati.setTitle(setGujarati, for: .normal)
        
    }
    
    /// Setup different widths for iPad and iPhone
    private func preferredAlertWidth() {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
                alertWidthConstraint.constant = 280.0
        case .pad:
                alertWidthConstraint.constant = 340.0
        case .unspecified: break
        case .tv: break
        case .carPlay: break
        default:
            break
        }
    }
    
    /// Create and Configure Alert Controller
    private func configure(message: String, btnCancelTitle: String?) {
        self.strAlertText          = message
        self.btnCancelTitle     = btnCancelTitle
    }
    
    private func configure2(message: String, btnCancelTitle: String?, btnOtherTitle: String?) {
        self.strAlertText          = message
        self.btnCancelTitle     = btnCancelTitle
        self.btnOtherTitle    = btnOtherTitle
        self.btn2Title = "Upload Signature"
    }
    
    /// Show Alert Controller
    private func show() {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.addChild(self)
            topViewController.view.addSubview(view)
            viewWillAppear(true)
            didMove(toParent: topViewController)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.alpha = 0.0
            view.frame = topViewController.view.bounds
            
            viewAlert.alpha     = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.view.alpha = 1.0
            }, completion: nil)
            
            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                self.viewAlert.alpha = 1.0
                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
            }, completion: nil)
        }
    }
    
    private func show2() {
        if let appDelegate = UIApplication.shared.delegate, let window = appDelegate.window, let rootViewController = window?.rootViewController {
            
            var topViewController = rootViewController
            while topViewController.presentedViewController != nil {
                topViewController = topViewController.presentedViewController!
            }
            
            topViewController.addChild(self)
            topViewController.view.addSubview(view)
            viewWillAppear(true)
            didMove(toParent: topViewController)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.alpha = 0.0
            view.frame = topViewController.view.bounds
            
            viewAlert.alpha     = 0.0
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: { () -> Void in
                self.view.alpha = 1.0
            }, completion: nil)
            
            viewAlert.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-10)
            UIView.animate(withDuration: 0.2, delay: 0.1, options: .curveEaseOut, animations: { () -> Void in
                self.viewAlert.alpha = 1.0
                self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0))
            }, completion: nil)
        }
    }
    
    /// Hide Alert Controller
    private func hide() {
        self.view.endEditing(true)
        self.viewAlert.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseIn, animations: { () -> Void in
            self.viewAlert.alpha = 0.0
            self.viewAlert.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            self.viewAlert.center    = CGPoint(x: (self.view.bounds.size.width/2.0), y: (self.view.bounds.size.height/2.0)-5)
        }, completion: nil)
        
        UIView.animate(withDuration: 0.25, delay: 0.05, options: .curveEaseIn, animations: { () -> Void in
            self.view.alpha = 0.0
            
        }, completion: {_ in
            
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    // MARK: - UIButton Clicks
    // MARK: -
    
    @IBAction func btnCancelTapped(sender: UIButton) {
        block!!(0, btnCancelTitle!)
        hide()
    }
    
    @IBAction func btnOtherTapped(sender: UIButton) {
       
        hide()
    }
    
    @IBAction func btnOkTapped(sender: UIButton) {
        block!!(0, "OK")
        hide()
    }
    
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender: AnyObject) {
        hide()
    }

    // MARK: - AJAlert Functions
    // MARK: -

    /**
     Display an Alert
     
     - parameter aStrMessage:    Message to display in Alert
     - parameter aCancelBtnTitle: Cancel button title
     - parameter aOtherBtnTitle: Other button title
     - parameter otherButtonArr: Array of other button title
     - parameter completion:     Completion block. Other Button Index - 1 and Cancel Button Index - 0
     */
    
    public func showAlert( aStrMessage: String, aCancelBtnTitle: String?, isDACCode: Bool = false, completion: AlertCompletionBlock) {
        configure( message: aStrMessage, btnCancelTitle: aCancelBtnTitle)
        self.isDACCode = isDACCode
        show()
        setupLanguageAlertView()
        block = completion
    }
    
    public func showAlert2( aStrMessage: String, aCancelBtnTitle: String?, aOtherBtnTitle: String?, completion: AlertCompletionBlock) {
        configure2( message: aStrMessage, btnCancelTitle: aCancelBtnTitle, btnOtherTitle: aOtherBtnTitle)
        show2()
        block = completion
    }
    

    @IBAction func actionTelugu(_ sender: UIButton) {
       
    }
    @IBAction func actionKannada(_ sender: UIButton) {
      
    }
    @IBAction func actionHindi(_ sender: UIButton) {
       
    
    }
    @IBAction func actionMarathi(_ sender: UIButton) {
       
      
    }
    @IBAction func actionGujarati(_ sender: UIButton) {
   
    }
}
