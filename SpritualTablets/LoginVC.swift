//
//  LoginVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 02/06/23.
//

import UIKit
import CoreTelephony
// import FirebaseFirestore
import FirebaseCore
import Firebase
import FirebaseDatabase
import FirebaseAuth
import GoogleSignIn
import IQKeyboardManagerSwift
import AuthenticationServices
import CryptoKit

class LoginVC: UIViewController {
    @IBOutlet weak var getOtpBtn: UIButton!
    @IBOutlet weak var mobileNoTxt: UITextField!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var countriesView: UIView!
    @IBOutlet weak var countriesTblView: UITableView!
    @IBOutlet weak var btnCountryFlagName: UIButton!
    @IBOutlet weak var otpNumberTxt: UITextField!
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var verifyOtpBtn: UIButton!
    @IBOutlet weak var loginProviderStackView: UIStackView!
    let defaults = UserDefaults.standard
    var countriCodes = [String]()
    var countriesData = [(name: String, flag: String)]()
    var countryFlagg: String = ""
    var phoneNumberCode = ""
    // Unhashed nonce.
    fileprivate var currentNonce: String?
    
    var countries: [String] = {

        var arrayOfCountries: [String] = []

        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            arrayOfCountries.append(name)
        }

        return arrayOfCountries
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.navigationBar.isHidden = true
        heightConstraint.constant = 20
        setupProviderLoginView()
        for code in NSLocale.isoCountryCodes  {
            
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            var greet = id
            var i = greet.index(greet.startIndex, offsetBy: 0)
            greet.remove(at: i)
            let phonenumberss = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            
            if let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) {
                var names = name
                names += " \((greet))"
                countriesData.append((name: names, flag: flag!))
            }else{
                //"Country not found for code: \(code)"
            }
        }
        
        print("Countries Flag Data is \(countriesData)")
        countriesTblView.reloadData()
        let currentLocale = NSLocale.current
        for code in NSLocale.isoCountryCodes  {
            let countryCode = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            print("country code is \(countryCode)")
            print(getCountryCallingCode(countryRegionCode: countryCode))
        }
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            let strCode = Countries.countryFromCountryCode(countryCode: countryCode)
            self.phoneNumberCode = "+\(strCode.phoneExtension)"
            print("Phone Number CountryCode is \(self.phoneNumberCode)")
            
        }
        let counrtruCodee = self.getCountryCode()
        print("country code112 is \(counrtruCodee)")
        if countryFlagg != "" {
            btnCountryFlagName.setTitle(countryFlagg, for: .normal)
        }
        if Auth.auth().currentUser != nil {
            print("User found In ")
        } else {
            print("User not found")
        }
        self.addDoneButtonOnKeyboard()
        self.otpNumberTxt.isHidden = true
        self.verifyOtpBtn.isHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        performExistingAccountSetupFlows()
    }
    private func randomNonceString(length: Int = 32) -> String {
      precondition(length > 0)
      var randomBytes = [UInt8](repeating: 0, count: length)
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
      if errorCode != errSecSuccess {
        fatalError(
          "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
        )
      }

      let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

      let nonce = randomBytes.map { byte in
        // Pick a random character from the set, wrapping around if needed.
        charset[Int(byte) % charset.count]
      }

      return String(nonce)
    }
    private func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
    
    
    // - Tag: perform_appleid_password_request
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]
        
        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    func getCountryCode() -> String {
        guard let carrier = CTTelephonyNetworkInfo().subscriberCellularProvider, let countryCode = carrier.isoCountryCode else { return "" }
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryCode.uppercased()] ?? ""
        return countryDialingCode
    }
    func getCountryCallingCode(countryRegionCode:String)->String{
        
        let prefixCodes = ["AF": "93", "AE": "971", "AL": "355", "AN": "599", "AS":"1", "AD": "376", "AO": "244", "AI": "1", "AG":"1", "AR": "54","AM": "374", "AW": "297", "AU":"61", "AT": "43","AZ": "994", "BS": "1", "BH":"973", "BF": "226","BI": "257", "BD": "880", "BB": "1", "BY": "375", "BE":"32","BZ": "501", "BJ": "229", "BM": "1", "BT":"975", "BA": "387", "BW": "267", "BR": "55", "BG": "359", "BO": "591", "BL": "590", "BN": "673", "CC": "61", "CD":"243","CI": "225", "KH":"855", "CM": "237", "CA": "1", "CV": "238", "KY":"345", "CF":"236", "CH": "41", "CL": "56", "CN":"86","CX": "61", "CO": "57", "KM": "269", "CG":"242", "CK": "682", "CR": "506", "CU":"53", "CY":"537","CZ": "420", "DE": "49", "DK": "45", "DJ":"253", "DM": "1", "DO": "1", "DZ": "213", "EC": "593", "EG":"20", "ER": "291", "EE":"372","ES": "34", "ET": "251", "FM": "691", "FK": "500", "FO": "298", "FJ": "679", "FI":"358", "FR": "33", "GB":"44", "GF": "594", "GA":"241", "GS": "500", "GM":"220", "GE":"995","GH":"233", "GI": "350", "GQ": "240", "GR": "30", "GG": "44", "GL": "299", "GD":"1", "GP": "590", "GU": "1", "GT": "502", "GN":"224","GW": "245", "GY": "595", "HT": "509", "HR": "385", "HN":"504", "HU": "36", "HK": "852", "IR": "98", "IM": "44", "IL": "972", "IO":"246", "IS": "354", "IN": "91", "ID":"62", "IQ":"964", "IE": "353","IT":"39", "JM":"1", "JP": "81", "JO": "962", "JE":"44", "KP": "850", "KR": "82","KZ":"77", "KE": "254", "KI": "686", "KW": "965", "KG":"996","KN":"1", "LC": "1", "LV": "371", "LB": "961", "LK":"94", "LS": "266", "LR":"231", "LI": "423", "LT": "370", "LU": "352", "LA": "856", "LY":"218", "MO": "853", "MK": "389", "MG":"261", "MW": "265", "MY": "60","MV": "960", "ML":"223", "MT": "356", "MH": "692", "MQ": "596", "MR":"222", "MU": "230", "MX": "52","MC": "377", "MN": "976", "ME": "382", "MP": "1", "MS": "1", "MA":"212", "MM": "95", "MF": "590", "MD":"373", "MZ": "258", "NA":"264", "NR":"674", "NP":"977", "NL": "31","NC": "687", "NZ":"64", "NI": "505", "NE": "227", "NG": "234", "NU":"683", "NF": "672", "NO": "47","OM": "968", "PK": "92", "PM": "508", "PW": "680", "PF": "689", "PA": "507", "PG":"675", "PY": "595", "PE": "51", "PH": "63", "PL":"48", "PN": "872","PT": "351", "PR": "1","PS": "970", "QA": "974", "RO":"40", "RE":"262", "RS": "381", "RU": "7", "RW": "250", "SM": "378", "SA":"966", "SN": "221", "SC": "248", "SL":"232","SG": "65", "SK": "421", "SI": "386", "SB":"677", "SH": "290", "SD": "249", "SR": "597","SZ": "268", "SE":"46", "SV": "503", "ST": "239","SO": "252", "SJ": "47", "SY":"963", "TW": "886", "TZ": "255", "TL": "670", "TD": "235", "TJ": "992", "TH": "66", "TG":"228", "TK": "690", "TO": "676", "TT": "1", "TN":"216","TR": "90", "TM": "993", "TC": "1", "TV":"688", "UG": "256", "UA": "380", "US": "1", "UY": "598","UZ": "998", "VA":"379", "VE":"58", "VN": "84", "VG": "1", "VI": "1","VC":"1", "VU":"678", "WS": "685", "WF": "681", "YE": "967", "YT": "262","ZA": "27" , "ZM": "260", "ZW":"263"]
        let countryDialingCode = prefixCodes[countryRegionCode]
        return countryDialingCode ?? ""
    }
    
    func isNilValue(assignValue: String?) -> String {
        if assignValue != nil {
            return assignValue!
        } else {
            return ""
        }
    }
    func addDoneButtonOnKeyboard() {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.mobileNoTxt.inputAccessoryView = doneToolbar
        self.otpNumberTxt.inputAccessoryView = doneToolbar
    }
    /// - Tag: add_appleid_button
    func setupProviderLoginView() {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        self.loginProviderStackView.addArrangedSubview(authorizationButton)
    }
    /// - Tag: perform_appleid_request
    @objc
    func handleAuthorizationAppleIDButtonPress() {
       // let nonce = randomNonceString()
       //  currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
      //  request.nonce = sha256(nonce)
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    @objc func doneButtonAction() {
        self.mobileNoTxt.resignFirstResponder()
        self.otpNumberTxt.resignFirstResponder()
    }
    @IBAction func verifyOtpBtnAction(_ sender: UIButton) {
        spinnerCreation(view: self.view, isStart: true)
        if otpNumberTxt.text! == "" || otpNumberTxt.text!.isEmpty {
            
            self.view.makeToast("Please Enter Otp", duration: 3.0, position: .center)
        } else {
           // guard let verificationCode = self.otpNumberTxt.text else { return }
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: otpNumberTxt.text!)
            
            Auth.auth().signIn(with: credential) { (user, error) in
                if let error = error {
                    spinnerCreation(view: self.view, isStart: false)
                    print(error.localizedDescription)
                    // complition(false)
                    self.view.makeToast("OTP entered is incorrect", duration: 3.0, position: .center)
                    return
                }
                print("Mobile User:\(String(describing: user?.user.phoneNumber))")
               // UserDefaults.standard.removeObject(forKey: "userLoginMobile")
                if isNil(assignValue: UserDefaults.standard.string(forKey: "userLoginMobile")) == "" {
                    UserDefaults.standard.set(user?.user.phoneNumber, forKey: "userLoginMobile")
                }
                if isNil(assignValue: UserDefaults.standard.string(forKey: "userDisplayName")) == "" {
                    UserDefaults.standard.set(user?.user.displayName, forKey: "userDisplayName")
                }
                spinnerCreation(view: self.view, isStart: false)
                guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC else { return }
                self.navigationController?.pushViewController(dashboardVC, animated: false)
            }
        }
    }
    
    @IBAction func getOtpAction(_ sender: UIButton) {
       // 73 , 20
        spinnerCreation(view: self.view, isStart: true)
        if mobileNoTxt.text! == "" || mobileNoTxt.text!.isEmpty {
            
            self.view.makeToast("Please Enter Mobile Number", duration: 3.0, position: .center)
        } else {
            let extensionNumber = "\(self.phoneNumberCode)\(mobileNoTxt.text!)"
            PhoneAuthProvider.provider().verifyPhoneNumber(extensionNumber, uiDelegate: nil) { (verificationID, error) in
                
                if let error = error {
                    print(error)
                    spinnerCreation(view: self.view, isStart: false)
                    self.view.makeToast("Your mobile number is not valid", duration: 3.0, position: .center)
                    //  complition(false)
                    return
                }
                spinnerCreation(view: self.view, isStart: false)
                self.heightConstraint.constant = 73
                self.otpNumberTxt.isHidden = false
                self.getOtpBtn.isHidden = true
                self.verifyOtpBtn.isHidden = false
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                UserDefaults.standard.set("PHONE", forKey: "login_by")
            }
        }
    }
    
    @IBAction func getCountriesDataAction(_ sender: UIButton) {
        countriesView.frame.size.width = self.view.frame.size.width
        countriesView.frame.size.height = self.view.frame.size.height
        self.view.addSubview(countriesView)
        
    }
    @IBAction func gmailLogin(_ sender: Any) {
        spinnerCreation(view: self.view, isStart: true)
        UserDefaults.standard.set("GOOGLE", forKey: "login_by")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [unowned self] result, error in
            if let error = error {
                spinnerCreation(view: self.view, isStart: false)
                print(error)
                return
            }
          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
            else {
              return
          }
            
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    spinnerCreation(view: self.view, isStart: false)
                    print("Error occurs when authenticate with Firebase: \(error.localizedDescription)")
                }
                print("Gmail User:\(String(describing: authResult?.user))")
                let userEmail = authResult?.user.email
               // let fullName = authResult?.additionalUserInfo?.profile.
               // UserDefaults.standard.removeObject(forKey: "userLoginEmail")
                if isNil(assignValue: UserDefaults.standard.string(forKey: "userLoginEmail")) == "" {
                    UserDefaults.standard.set(userEmail, forKey: "userLoginEmail")
                }
                if isNil(assignValue: UserDefaults.standard.string(forKey: "userDisplayName")) == "" {
                    UserDefaults.standard.set(authResult?.user.displayName, forKey: "userDisplayName")
                }
                spinnerCreation(view: self.view, isStart: false)
                self.view.makeToast("Google SignIn Successfully", duration: 3.0, position: .center)
                guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC else { return }
                self.navigationController?.pushViewController(dashboardVC, animated: false)
            }

        }
    }
}
extension LoginVC {
    
    
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

       // lblAlertText?.font = UIFont(name: "Roboto-Medium", size: 20.0)
        
    }
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender: AnyObject) {
        hide()
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self.view)
            // do something with your currentPoint
        }
        self.countriesView.removeFromSuperview()
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
}

extension LoginVC: UITableViewDataSource, UITableViewDelegate {
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.countriesData.count
    }
    
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          guard let cell = countriesTblView.dequeueReusableCell(withIdentifier: CountriesCell.cellIidentifier) as? CountriesCell else {
              return UITableViewCell()
          }
        let country = countriesData[indexPath.row]
        cell.lblCountryName.text = country.name
        cell.btnCountryFlag.setTitle(country.flag, for: .normal)
        cell.accessoryType = .none
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
         let country = countriesData[indexPath.row]
         countryFlagg = country.flag
         btnCountryFlagName.setTitle(countryFlagg, for: .normal)
         self.countriesView.removeFromSuperview()
    }
}

class CountriesCell: UITableViewCell {

    // MARK: @IBOutlet
    @IBOutlet weak var btnCountryFlag: UIButton!
    @IBOutlet weak var lblCountryName: UILabel!
    @IBOutlet weak var lblCountryPhnCode: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        btnCountryFlag.isUserInteractionEnabled = false
    }

    internal static var cellIidentifier: String {
        return String(describing: self)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension LoginVC: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
//    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
//        UserDefaults.standard.set("APPLE", forKey: "login_by")
//        switch authorization.credential {
//        case let appleIDCredential as ASAuthorizationAppleIDCredential:
//            
//            // Create an account in your system.
//            let userIdentifier = appleIDCredential.user
//            let fullName = appleIDCredential.fullName
//            let email = appleIDCredential.email
//            
//            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
//            self.saveUserInKeychain(userIdentifier)
//            
//            guard let nonce = currentNonce else {
//                fatalError("Invalid state: A login callback was received, but no login request was sent.")
//            }
//            guard let appleIDToken = appleIDCredential.identityToken else {
//                print("Unable to fetch identity token")
//                return
//            }
//            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
//                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
//                return
//            }
//            // Initialize a Firebase credential, including the user's full name.
//            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString,
//                                                           rawNonce: nonce,
//                                                           fullName: appleIDCredential.fullName)
//            // Sign in with Firebase.
//            Auth.auth().signIn(with: credential) { (authResult, error) in
//                if (error != nil) {
//                    
//                    print(error?.localizedDescription ?? "")
//                    return
//                }
//                // User is signed in to Firebase with Apple.
//                // ...
//                print("Apple User:\(String(describing: authResult?.user))")
//                let userEmail = authResult?.user.email
//               // let fullName = authResult?.additionalUserInfo?.profile.
//                if isNil(assignValue: UserDefaults.standard.string(forKey: "userLoginEmail")) == "" {
//                    UserDefaults.standard.set(userEmail, forKey: "userLoginEmail")
//                }
//                spinnerCreation(view: self.view, isStart: false)
//                self.view.makeToast("Apple SignIn Successfully", duration: 3.0, position: .center)
//                guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC else { return }
//                //   viewController.userIdentifierLabel.text = userIdentifier
//                if let givenName = fullName?.givenName {
//                    dashboardVC.fullName = givenName
//                }
//                if let familyName = fullName?.familyName {
//                    dashboardVC.familyName = familyName
//                }
//                if let email = email {
//                    dashboardVC.emailTxt = email
//                }
//                self.navigationController?.pushViewController(dashboardVC, animated: false)
//            }
//        
//        case let passwordCredential as ASPasswordCredential:
//        
//            // Sign in using an existing iCloud Keychain credential.
//            let username = passwordCredential.user
//            let password = passwordCredential.password
//            
//            // For the purpose of this demo app, show the password credential as an alert.
//            DispatchQueue.main.async {
//                self.showPasswordCredentialAlert(username: username, password: password)
//            }
//            
//        default:
//            break
//        }
//    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        UserDefaults.standard.set("APPLE", forKey: "login_by")
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            UserDefaults.standard.set(fullName, forKey: "userDisplayName")
            UserDefaults.standard.set(email, forKey: "userLoginEmailApple")
            
            // For the purpose of this demo app, show the Apple ID credential information in the `ResultViewController`.
            self.showResultViewController(userIdentifier: userIdentifier, fullName: fullName, email: email)
            
        case let passwordCredential as ASPasswordCredential:
            
            // Sign in using an existing iCloud Keychain credential.
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            // For the purpose of this demo app, show the password credential as an alert.
            DispatchQueue.main.async {
                self.showPasswordCredentialAlert(username: username, password: password)
            }
            
        default:
            break
        }
    }
    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
        guard let dashboardVC = self.presentingViewController as? DashboardVC
        else { return }
        
        DispatchQueue.main.async {
            //  viewController.userIdentifierLabel.text = userIdentifier
            if let givenName = fullName?.givenName {
                dashboardVC.fullName = givenName
            }
            if let familyName = fullName?.familyName {
                dashboardVC.familyName = familyName
            }
            if let email = email {
                dashboardVC.emailTxt = email
            }
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.sarandatech.spiritualtablets", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
            print("Sign in with Apple errored: \(error)")
    }
}

extension LoginVC: ASAuthorizationControllerPresentationContextProviding {
    /// - Tag: provide_presentation_anchor
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
