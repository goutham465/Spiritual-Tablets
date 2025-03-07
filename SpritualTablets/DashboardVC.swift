//
//  DashboardVC.swift
//  ePicConsumerIOSApplication
//
//  Created by IBM Mac on 29/03/22.
//  Copyright © 2022 jarvis. All rights reserved.
//

import Foundation
import UIKit
import FirebaseCore
import Firebase
import FirebaseDatabase
import FirebaseAuth
// import FirebaseFirestore


class DashboardVC: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var viewAlert: UIView!
    @IBOutlet weak var eventsView: UIView!
    @IBOutlet weak var viewAlert1: UIView!
    
    @IBOutlet weak var audioBooksPopView: UIView!
    @IBOutlet weak var audioViewAlert: UIView!
    
    @IBOutlet weak var videosPopView: UIView!
    @IBOutlet weak var videosViewAlert: UIView!
    
    @IBOutlet weak var counsellingView: UIView!
    @IBOutlet weak var counsellingAlert: UIView!
    
    @IBOutlet var lblAlertText: UILabel?
    @IBOutlet var btnCancel: UIButton!
    @IBOutlet var viewAlertBtns: UIView!
    @IBOutlet var alertWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var btnTelugu: UIButton!
    @IBOutlet weak var btnHindi: UIButton!
    @IBOutlet weak var btnKannada: UIButton!
    @IBOutlet weak var btnTamil: UIButton!
    @IBOutlet weak var btnEnglish: UIButton!
    
    @IBOutlet var anandhoEventBtn: UIButton!
    @IBOutlet var meditaionBtn: UIButton!
    @IBOutlet var workShopBtn: UIButton!
    @IBOutlet weak var zoomSessionBtnLink: UIButton!
    var weeklyQuoteDataArray = [String]()
    var imageItemsArray = ["daily_tip", "audio", "book", "audio_book", "video", "events", "letter", "gallery", "register", "cousnelling", "donate", "admission_center", "contact_us", "about_us", "profile", "logout", "logout"]
    var labelNamesArray = ["WEEKLY QUOTE", "MUSIC FOR MEDITATION", "BOOKS", "AUDIO BOOKS", "VIDEOS", "EVENTS", "NEWS LETTER", "GALLERY", "VOLUNTEER REGISTRATIONS", "REQUEST FOR COUNSELLING", "DONATE", "ADMISSION CENTERS", "CONTACT US", "ABOUT US", "MY PROFILE", "LOGOUT", "Delete Account"]
    
    private let btnCancelColor =  ColorConverter.hexStringToUIColor(hex: "F7B245")

    private var timer: Timer?
    var timeInterval: TimeInterval = 5.0
    var selctedCell: Int?
    let defaults = UserDefaults.standard

    // PROPERTY::-
    var partnerCode: String = ""
    var ucmId: String = ""
    weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    private var strAlertText = String()
    private var btnCancelTitle: String?
    private var btnOtherTitle: String?
    var remoteConfig: RemoteConfig!
    
    var admisionCenteresArray = [String]()
    var eventTypesArray = [String]()
    
    var eventNameArray = [String]()
    var eventTimingArray = [String]()
    var eventDescriptionArr = [String]()
    var eventLinksArray = [String]()
    var eventImagesArray = [String]()
    var eventLink2 = [String]()
    
    var selectedItem = ""
    var fullName = ""
    var emailTxt = ""
    var familyName = ""
    var galleryHeaderLabelArray = [String]()
    var galleryImagesArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionVW.showsHorizontalScrollIndicator = false
        collectionVW.reloadData()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationItem.setHidesBackButton(true, animated: true)
        let ref111 = Database.database().reference()
        print(ref111)
        remoteConfig = RemoteConfig.remoteConfig()
        let rootRef = Database.database().reference(withPath: "Admission Centers")
        print("Rootref:\(rootRef)")
//        ref111.child("Admission Centers").observe(.value, with: { snapshot in
//                   for child in snapshot.children {
//                       let valueD = child as! DataSnapshot
//                       let keyD = valueD.key
//                       let value1 = valueD.value
//                       self.admisionCenteresArray.append(keyD)
//                   }
//               })
        checkUserLoggedIn()
        fetchUsersData()
        let link = "Ektha Dhyanam 5:00am To 6:30am 9:30pm To 11pm and Spiritual Class at 2:00pm to 4:00pm Every Day".uppercased()
        zoomSessionBtnLink.setTitle(link, for: .normal)
        zoomSessionBtnLink.setTitleColor(UIColor.white, for: .normal)
    }
    
    func fetchUsersData() {
        Database.database().reference().child("Admission Centers").observe(.childAdded) { (snapshot) in
            
        }
        self.getFirebaseData()
    }
    func checkUserLoggedIn() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            print("User not found")
            return
        }
        print("LoggedIn:\(uid)")
    }
    @IBAction func zoomSessionAction(sender: UIButton) {
        let url = URL(string: "https://us02web.zoom.us/j/6998042869?pwd=ZVJZelhBcGhIR0VZbllzSjh5V0xVQT09")
        UIApplication.shared.open(url!, options: [:])
    }
    @IBAction func btnCancelTapped(sender: UIButton) {
        if selectedItem == BookVary.audios {
            self.audioBooksPopView.removeFromSuperview()
        } else if selectedItem == BookVary.videos {
            self.videosPopView.removeFromSuperview()
        } else if selectedItem == BookVary.counsellingRequest {
            self.counsellingView.removeFromSuperview()
        } else if selectedItem == BookVary.events {
            self.eventsView.removeFromSuperview()
        } else {
            self.popView.removeFromSuperview()
        }
    }
    
    @IBAction func actionKannada(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
        if selectedItem == BookVary.audios{
            
            meditaionVC.isComingFrom = BookVary.audios
            meditaionVC.languageSelect = LanguagesTypes.kannada.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
            
        } else if selectedItem == BookVary.counsellingRequest {
            
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let requestCounselingVC = storyboard.instantiateViewController(withIdentifier: "RequestCounsellingVC") as? RequestCounsellingVC else { return }
            requestCounselingVC.isComingAbout = CounsellingLanguage.kannada.rawValue
            self.navigationController?.pushViewController(requestCounselingVC, animated: false)
            
        } else {
            meditaionVC.isComingFrom = BookVary.books
            meditaionVC.languageSelect = LanguagesTypes.kannada.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        }
    }
    @IBAction func actionHindi(_ sender: UIButton) {
       
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
        if selectedItem == BookVary.audios{
            
            meditaionVC.isComingFrom = BookVary.audios
            meditaionVC.languageSelect = LanguagesTypes.hindi.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
            
        } else if selectedItem == BookVary.videos {
            
            meditaionVC.isComingFrom = BookVary.videos
            meditaionVC.languageSelect = LanguagesTypes.hindi.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        } else if selectedItem == BookVary.counsellingRequest {
            
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let requestCounselingVC = storyboard.instantiateViewController(withIdentifier: "RequestCounsellingVC") as? RequestCounsellingVC else { return }
            requestCounselingVC.isComingAbout = CounsellingLanguage.hindi.rawValue
            self.navigationController?.pushViewController(requestCounselingVC, animated: false)
            
        } else {
            meditaionVC.isComingFrom = BookVary.books
            meditaionVC.languageSelect = LanguagesTypes.hindi.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        }
    }
    @IBAction func actionTamil(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
        meditaionVC.isComingFrom = BookVary.books
        meditaionVC.languageSelect = LanguagesTypes.tamil.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
      
    }
    @IBAction func actionUSA(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let requestCounselingVC = storyboard.instantiateViewController(withIdentifier: "RequestCounsellingVC") as? RequestCounsellingVC else { return }
        requestCounselingVC.isComingAbout = CounsellingLanguage.usa.rawValue
        self.navigationController?.pushViewController(requestCounselingVC, animated: false)
      
    }
   
    @IBAction func actionTelugu(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
       // meditaionVC.eventsName = self.eventTypesArray[1]
        if selectedItem == BookVary.audios {
            
            meditaionVC.isComingFrom = BookVary.audios
            meditaionVC.languageSelect = LanguagesTypes.telugu.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
            
        } else if selectedItem == BookVary.videos {
            
            meditaionVC.isComingFrom = BookVary.videos
            meditaionVC.languageSelect = LanguagesTypes.telugu.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
            
        } else if selectedItem == BookVary.counsellingRequest {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let requestCounselingVC = storyboard.instantiateViewController(withIdentifier: "RequestCounsellingVC") as? RequestCounsellingVC else { return }
            requestCounselingVC.isComingAbout = CounsellingLanguage.telugu.rawValue
            self.navigationController?.pushViewController(requestCounselingVC, animated: false)
            
        } else {
            meditaionVC.isComingFrom = BookVary.books
            meditaionVC.languageSelect = LanguagesTypes.telugu.rawValue
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        }
        
        
    }
    @IBAction func actionEnglish(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
      //  meditaionVC.isComingFrom = LanguagesTypes.english.rawValue
         if selectedItem == BookVary.videos {
            
            meditaionVC.isComingFrom = BookVary.videos
            meditaionVC.languageSelect = LanguagesTypes.english.rawValue
         } else {
             meditaionVC.isComingFrom = BookVary.books
             meditaionVC.languageSelect = LanguagesTypes.english.rawValue
         }
        self.navigationController?.pushViewController(meditaionVC, animated: false)
    }
    @IBAction func actionMarathi(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
        meditaionVC.isComingFrom = BookVary.audios
        meditaionVC.languageSelect = LanguagesTypes.marathi.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
        
        
    }
    @IBAction func actionGujarati(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "BooksContentVC") as? BooksContentVC else { return }
        meditaionVC.isComingFrom = BookVary.audios
        meditaionVC.languageSelect = LanguagesTypes.gujarati.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
        
        
    }
    @IBAction func eventMeditaionAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "EventTypesVC") as? EventTypesVC else { return }
        meditaionVC.eventsName = self.eventTypesArray[1]
        meditaionVC.isComingFrom = EventsType.meditation.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
    }
    @IBAction func eventWorkshopAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "EventTypesVC") as? EventTypesVC else { return }
        meditaionVC.eventsName = self.eventTypesArray[2]
        meditaionVC.isComingFrom = EventsType.workShops.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
    }
    @IBAction func eventAnandhoBrahmaAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "EventTypesVC") as? EventTypesVC else { return }
        meditaionVC.eventsName = self.eventTypesArray[0]
        meditaionVC.isComingFrom = EventsType.anandhaoBrahmo.rawValue
        self.navigationController?.pushViewController(meditaionVC, animated: false)
    }
    func openWhatsapp(){
        // let urlWhats = "whatsapp://send?phone=(mobile number with country code)"
        let urlWhats = "whatsapp://send?phone=+919985466499&text=Hi,Is ANy one Available?"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
            if let whatsappURL = URL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL){
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(whatsappURL)
                    }
                }
                else {
                    print("Install Whatsapp")
                }
            }
        }
    }
    @IBAction func whatsAppLinkAction(_ sender: UIButton) {
        openWhatsapp()
    }
    @IBAction func shareAppAction(_ sender: UIButton) {
        if let urlStr = NSURL(string: "https://apps.apple.com/us/app/idxxxxxxxx?ls=1&mt=8") {
            let objectsToShare = [urlStr]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    func signoutDeleteAccount() {
        let loginBy = UserDefaults.standard.string(forKey: "login_by")
        if loginBy != nil && loginBy == "PHONE" {
            UserDefaults.standard.removeObject(forKey: "login_by")
            UserDefaults.standard.removeObject(forKey: "userLoginMobile")
        } else if loginBy != nil && loginBy == "GOOGLE" {
            UserDefaults.standard.removeObject(forKey: "login_by")
            UserDefaults.standard.removeObject(forKey: "userLoginEmail")
        } else if loginBy != nil && loginBy == "APPLE" {
            UserDefaults.standard.removeObject(forKey: "login_by")
            UserDefaults.standard.removeObject(forKey: "userLoginEmailApple")
        }
    }
}

extension DashboardVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.labelNamesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardeCollectionCell", for: indexPath) as? DashboardeCollectionCell {
            customCell.labelName.text = labelNamesArray[indexPath.row]
            customCell.imageItem.image = UIImage(named: imageItemsArray[indexPath.row])
            customCell.cardView.layer.cornerRadius = 4
            customCell.cardView.layer.borderWidth = 2
            customCell.cardView.layer.borderColor = UIColor.white.cgColor
            cell = customCell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10.0
    }

}
extension DashboardVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let object = labelNamesArray[indexPath.row]
        if indexPath.item == 0 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let weeklyQuoteVC = storyboard.instantiateViewController(withIdentifier: "WeeklyQuoteVC") as? WeeklyQuoteVC else { return }
            weeklyQuoteVC.weekQuoteText = self.weeklyQuoteDataArray
            self.navigationController?.pushViewController(weeklyQuoteVC, animated: false)
        }
        if indexPath.item == 1 {
            guard let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "MusicMeditationVC") as? MusicMeditationVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 2 {
            
            selectedItem = object
            popView.frame.size.width = self.view.frame.size.width
            popView.frame.size.height = self.view.frame.size.height
            self.view.addSubview(popView)
        }
        if indexPath.item == 3 {
            
            selectedItem = object
            audioBooksPopView.frame.size.width = self.view.frame.size.width
            audioBooksPopView.frame.size.height = self.view.frame.size.height
            self.view.addSubview(audioBooksPopView)
            
        }
        if indexPath.item == 4 {
            
            selectedItem = object
            videosPopView.frame.size.width = self.view.frame.size.width
            videosPopView.frame.size.height = self.view.frame.size.height
            self.view.addSubview(videosPopView)
            
        }
        if indexPath.item == 5 {
            selectedItem = object
            spinnerCreation(view: self.view, isStart: true)
            let ref111 = Database.database().reference()
            print(ref111)
            ref111.child("events").observe(.value, with: { snapshot in
                for child in snapshot.children {
                    let valueD = child as! DataSnapshot
                    let keyD = valueD.key
                    let value1 = valueD.value
                    print("eventsData: \(keyD)")
                    print("eventsData Value: \(value1 ?? [])")
                    self.eventTypesArray.append(keyD)
                }
            })
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                // your code here
                spinnerCreation(view: self.view, isStart: false)
                self.eventsView.frame.size.width = self.view.frame.size.width
                self.eventsView.frame.size.height = self.view.frame.size.height
                self.view.addSubview(self.eventsView)
                self.anandhoEventBtn.setTitle(self.eventTypesArray[0], for: .normal)
                self.meditaionBtn.setTitle(self.eventTypesArray[1], for: .normal)
                self.workShopBtn.setTitle(self.eventTypesArray[2], for: .normal)
            }
            
        }
        if indexPath.item == 6 {
            guard let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "NewsLettersVC") as? NewsLettersVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 7 {
            self.galleryDbRetrieve()
        }
        if indexPath.item == 8 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let musicVC = storyboard.instantiateViewController(withIdentifier: "VolunteerRegistrationVC") as? VolunteerRegistrationVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 9 {
            selectedItem = object
            counsellingView.frame.size.width = self.view.frame.size.width
            counsellingView.frame.size.height = self.view.frame.size.height
            self.view.addSubview(counsellingView)
            
        }
       // 09 request counselling
       // 10 // Donate
        if indexPath.item == 10 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let musicVC = storyboard.instantiateViewController(withIdentifier: "DonateFundVC") as? DonateFundVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 11 {
            guard let admissionCentersVc = self.storyboard?.instantiateViewController(withIdentifier: "AdmissionCentersVC") as? AdmissionCentersVC else { return }
           // admissionCentersVc.admisionCenteresDataArray = self.admisionCenteresArray
            self.navigationController?.pushViewController(admissionCentersVc, animated: false)
        }
        if indexPath.item == 12 {
            guard let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactUSVC") as? ContactUSVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 13 {
            guard let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "AboutUSVC") as? AboutUSVC else { return }
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 14 {
            guard let musicVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileUpdateVC") as? ProfileUpdateVC else { return }
            musicVC.fullName = self.fullName
            musicVC.emailId = self.emailTxt
            self.navigationController?.pushViewController(musicVC, animated: false)
        }
        if indexPath.item == 15 {
            do {
                try Auth.auth().signOut()
                self.signoutDeleteAccount()
                guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else { return }
                self.navigationController?.pushViewController(loginVC, animated: true)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
        if indexPath.item == 16 {
            do {
                let user = Auth.auth().currentUser

                user?.delete { error in
                  if let error = error {
                    // An error happened.
                      print ("Error Account: %@", error)
                  } else {
                    // Account deleted.
                      self.view.makeToast("Account Deleted Successfully", duration: 3.0, position: .bottom)
                      self.signoutDeleteAccount()
                      UserDefaults.standard.removeObject(forKey: "")
                      guard let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC else { return }
                      self.navigationController?.pushViewController(loginVC, animated: true)
                  }
                }
            } catch let signOutError as NSError {
                print ("Error Delete Account: %@", signOutError)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
}

extension DashboardVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}

class DashboardeCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var cardView: UIView!
    
}


class ColorConverter: UIColor {
    
    public static func hexStringToUIColor (hex: String) -> UIColor {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }
        
        if (cString.count) != 6 {
            return UIColor.gray
        }
        
        var rgbValue: UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension DashboardVC {
    
    
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
        
    }
    /// Hide Alert Controller on background tap
    @objc func backgroundViewTapped(sender: AnyObject) {
        hide()
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
extension String {

    static func emojiFlag(for countryCode: String) -> String! {
        func isLowercaseASCIIScalar(_ scalar: Unicode.Scalar) -> Bool {
            return scalar.value >= 0x61 && scalar.value <= 0x7A
        }

        func regionalIndicatorSymbol(for scalar: Unicode.Scalar) -> Unicode.Scalar {
            precondition(isLowercaseASCIIScalar(scalar))

            // 0x1F1E6 marks the start of the Regional Indicator Symbol range and corresponds to 'A'
            // 0x61 marks the start of the lowercase ASCII alphabet: 'a'
            return Unicode.Scalar(scalar.value + (0x1F1E6 - 0x61))!
        }

        let lowercasedCode = countryCode.lowercased()
        guard lowercasedCode.count == 2 else { return nil }
        guard lowercasedCode.unicodeScalars.reduce(true, { accum, scalar in accum && isLowercaseASCIIScalar(scalar) }) else { return nil }

        let indicatorSymbols = lowercasedCode.unicodeScalars.map({ regionalIndicatorSymbol(for: $0) })
        return String(indicatorSymbols.map({ Character($0) }))
    }
}

extension DashboardVC {
    func getFirebaseData() {
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("events").observe(.value, with: { snapshot in
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
              
            }
        })
        
       
    }
    func galleryDbRetrieve() {
        spinnerCreation(view: self.view, isStart: true)
        let galleryRef = Database.database().reference()
        galleryRef.child("gallery").observe(.value, with: { snapshot in
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
                self.galleryHeaderLabelArray.append(keyD)
                guard let valueImage = value1 as? NSArray else {return}
                for rowIndex in valueImage {
                    if let imgUrl = rowIndex as? String {
                        self.galleryImagesArray.append(imgUrl)
                    }
                }
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                spinnerCreation(view: self.view, isStart: false)
                let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
                guard let gallerYVC = storyboard.instantiateViewController(withIdentifier: "GalleryImagesVC") as? GalleryImagesVC else { return }
                gallerYVC.galleryImagesArray = self.galleryImagesArray
                gallerYVC.galleryHeaderLabelArray = self.galleryHeaderLabelArray
                print("GalleryImages:\(self.galleryImagesArray)")
                print("GalleryHeader Labels:\(self.galleryHeaderLabelArray)")
                self.navigationController?.pushViewController(gallerYVC, animated: false)
            }
            
        })
    }
    func getWeeklyQuote() {
        let ref111 = Database.database().reference()
        ref111.child("Weekly Quote").observe(.value, with: { snapshot in
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                _ = valueD.value
                print("WeeklyQuote key: \(keyD)")
                self.weeklyQuoteDataArray.append(keyD)
            }
        })
    }
}
class BookVary {
   
    static let books = "BOOKS"
    static let audios = "AUDIO BOOKS"
    static let videos = "VIDEOS"
    static let counsellingRequest = "REQUEST FOR COUNSELLING"
    static let events = "EVENTS"
}
