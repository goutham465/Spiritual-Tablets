//
//  RequestCounsellingVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 01/08/23.
//

import UIKit

enum CounsellingLanguage: String {
    
    case telugu = "TELUGU"
    case usa = "USA"
    case hindi = "HINDI"
    case kannada = "KANNADA"
}

class RequestCounsellingVC: UIViewController {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var labelStr: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var btnLink: UIButton!
    @IBOutlet weak var dataLabel2: UILabel!
    var isComingAbout = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        labelStr.text = isComingAbout
        
        if isComingAbout == CounsellingLanguage.usa.rawValue {
            dataLabel.text = "♦️ When the student is ready, the Master Appears ♦️\n\nNow avail Spiritual counselling opportunity with Spiritual Tablets Research Foundation under the guidance of Dr GK by Eminent Senior counsellors.\n\n🔹Virtual Spiritual Life & Health counselling Features USA🔹\nVirtually by Zoom\nPrior appointment will save time\nBreakout rooms for personal attention\nAssistance of Senior counsellors\nEminent spiritual training (one on one)\n\n🍁Every Saturday:\nUSA: 08.30 AM – 10.00AM EST\nIndia: 07.00PM – 08.30PM IST\n\n🍁To Register you may contact us by:\n\n1.Filling the attached google form for USA residents:\n2.Voluntary Support\nAshok: (USA) +1 (302) 465-5446\nVindhya: (USA) +1 (214) 418-4640\nVardhani: (India) +91 98499 85771\n\nThank You🙏\nTeam Spiritual Tablets"
            btnLink.setTitle("https://forms.gle/pYm7cmfkFseRc3M58", for: .normal)
            dataLabel2.isHidden = true
            
        } else if isComingAbout == CounsellingLanguage.hindi.rawValue {
            dataLabel.text = "आचार्य संगत्य रजिस्ट्रेशन फॉर्म\n\nAcharya Sangatya Registration form\n\nNow avail Spiritual counselling opportunity with Spiritual Tablets Research Foundation under the guidance of Dr GK by Eminent Spiritual counsellors.\n\n🔹Virtual Spiritual Life & Health counselling Features🔹\n\n1.Virtually by Zoom\n2.A prior appointment will save time\n3.Breakout rooms for personal attention\n4.The assistance of Senior counsellors\n5.Eminent spiritual training (one on one)\n\nTuesday 12.00 pm – 01.00 pm IST & Friday 3:00 pm – 5.00 pm IST\n\n🍁To Register, you may contact us by:\n1.Filling the attached google form:\n2.Phone: Archana: +91 99683 99965\nThank You🙏\nTeam Spiritual Tablets"
            btnLink.setTitle("https://forms.gle/2XUWTmFCHveRF72K6", for: .normal)
            dataLabel2.isHidden = true
        } else if isComingAbout == CounsellingLanguage.kannada.rawValue {
            dataLabel.text = "🌹 “ಆಚಾರ್ಯ ಸಂಗತ್ಯ”🌹\n\nಆಧ್ಯಾತ್ಮಿಕ ಮಾತ್ರೆಗಳ ಸಂಶೋಧನಾ ಪ್ರತಿಷ್ಠಾನದ(spiritual tablets research foundation) ಮೂಲಕ ಅದ್ಭುತ ಅವಕಾಶ!\n\n“ಆಧ್ಯಾತ್ಮಿಕ ಸಮಾಲೋಚನೆ”ಡಾ.ಜಿ.ಕೆ ಅವರ ಮಾರ್ಗದರ್ಶನದೊಂದಿಗೆ ಮತ್ತು ಹಿರಿಯ ಆಧ್ಯಾತ್ಮಿಕ ಸಲಹೆಗಾರರ ​​ಮೂಲಕ …\n\n1.ಆಧ್ಯಾತ್ಮಿಕ ಜೀವನಶೈಲಿ ಮತ್ತು ಆರೋಗ್ಯ ಸಲಹೆ.\n2.ಲೈವ್ ಜೂಮ್ ಸೆಷನ್‌ಗಳು.\n3.ಸಮಯ ವ್ಯರ್ಥ ಮಾಡದೆ ಮುಂಚಿತವಾಗಿ ಅಪಾಯಿಂಟ್ಮೆಂಟ್\n4.ವೈಯಕ್ತಿಕ ಗಮನಕ್ಕಾಗಿ (ಪ್ರತ್ಯೇಕವಾಗಿ) ಜೂಮ್‌ನಲ್ಲಿ ಕೊಠಡಿಗಳನ್ನು ವ್ಯವಸ್ಥೆ ಮಾಡಲಾಗಿದೆ.\n5.ವಿಶೇಷ ಆಧ್ಯಾತ್ಮಿಕ ತರಬೇತಿ(spiritualtraining). ಪ್ರತಿಭಾನುವಾರ 10:00 AM to 01:00 PM IST\n\nFor Registration please follow the URL\nಸಂಪರ್ಕಿಸಿ\n+91 9246648408\nಧನ್ಯವಾದಗಳು.🙏"
            btnLink.setTitle("https://forms.gle/2XUWTmFCHveRF72K6", for: .normal)
            dataLabel2.isHidden = true
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnLinkAction(_ sender: UIButton) {
        let YoutubeID =  "https://forms.gle/2XUWTmFCHveRF72K6"
        let appURL = NSURL(string: "\(YoutubeID)")!
        let webURL = NSURL(string: "\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
           // application.open(webURL as URL)
        }
    }

}
