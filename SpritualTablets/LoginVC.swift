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
    
    var countriCodes = [String]()
    var countriesData = [(name: String, flag: String)]()
    var countryFlagg: String = ""
    
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
      //  var countriesData = [(name: String, flag: String)]()
        
        for code in NSLocale.isoCountryCodes  {
            
            let flag = String.emojiFlag(for: code)
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            var greet = id
            var i = greet.index(greet.startIndex, offsetBy: 0)
            greet.remove(at: i)
          //  print("Result : \(greet)")
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
      //  print(countries)
        let currentLocale = NSLocale.current
     //   let countryCode = currentLocale.objectForKey(NSLocaleCountryCode) as! String//get the set country name, code of your iphone
        for code in NSLocale.isoCountryCodes  {
            let countryCode = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
           // print("country code is \(countryCode)")
          //  print(getCountryCallingCode(countryRegionCode: countryCode))
        }
        if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            print(countryCode)
            let strCode = Countries.countryFromCountryCode(countryCode: countryCode)
            print("country code11 is \(strCode.phoneExtension)")
           // btnPhoneCode.setTitle("+\(strCode.phoneExtension)", for: .normal)
            
        }
        let counrtruCodee = self.getCountryCode()
        print("country code112 is \(counrtruCodee)")
        if countryFlagg != "" {
            btnCountryFlagName.setTitle(countryFlagg, for: .normal)
        }
        if Auth.auth().currentUser != nil {
          // User is signed in.
          // ...
            print("User found In ")
        } else {
          // No user is signed in.
          // ...
            print("User not found")
        }
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
    
    @IBAction func getOtpAction(_ sender: UIButton) {
        
        guard let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardVC") as? DashboardVC else { return }
        self.navigationController?.pushViewController(dashboardVC, animated: false)
    }
    
    @IBAction func getCountriesDataAction(_ sender: UIButton) {
        countriesView.frame.size.width = self.view.frame.size.width
        countriesView.frame.size.height = self.view.frame.size.height
        self.view.addSubview(countriesView)
        
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
//         guard let cell = countriesTblView.dequeueReusableCell(withIdentifier: CountriesCell.cellIidentifier) as? CountriesCell else {
//             return UITableViewCell()
//         }
         let country = countriesData[indexPath.row]
        // cell.btnCountryFlag.tag = indexPath.row
         countryFlagg = country.flag
         btnCountryFlagName.setTitle(countryFlagg, for: .normal)
         self.countriesView.removeFromSuperview()
      //  delegate?.countriesViewController(countriesViewController: self, didSelectCountry: filteredCountries[indexPath.section][indexPath.row])
       // return cell
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
