//
//  AboutUSVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 18/05/23.
//

import UIKit

class AboutUSVC: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!


    var labelNamesArray = ["INTRODUCTION", "HISTORY & ORIGIN", "PRINCIPLE", "PYRAMID DOCTORS", "OUTLETS", "FOUNDER"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        collectionVW.showsHorizontalScrollIndicator = false
        collectionVW.reloadData()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)

    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func faceBookAction(_ sender: UIButton) {
        UIApplication.tryURL(urls: [
                        "fb://profile/spiritualtabletsofficial?mibextid=ZbWKwL",
                        "https://www.facebook.com/spiritualtabletsofficial?mibextid=ZbWKwL"
                        ])
    }
    @IBAction func youTubeActionTelugu(_ sender: UIButton) {
      //  playInYoutube(youtubeId: "https://www.youtube.com/channel/UCvdbtwFCC-4OYU7zy_bM9aw")
        let YoutubeID =  "https://www.youtube.com/channel/UCvdbtwFCC-4OYU7zy_bM9aw" // Your Youtube ID here
        let appURL = NSURL(string: "\(YoutubeID)")!
        let webURL = NSURL(string: "\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    @IBAction func youTubeActionHindi(_ sender: UIButton) {
       // playInYoutube(youtubeId: "https://www.youtube.com/channel/UCa7wUGcDCsX0KfNQnX-WNeg/videos")
        let YoutubeID =  "https://www.youtube.com/channel/UCa7wUGcDCsX0KfNQnX-WNeg/videos" // Your Youtube ID here
        let appURL = NSURL(string: "\(YoutubeID)")!
        let webURL = NSURL(string: "\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    @IBAction func youTubeActionEnglish(_ sender: UIButton) {
        // playInYoutube(youtubeId: "https://www.youtube.com/channel/UCRIdLxE7-YefPnNJOraYThQ")
        let YoutubeID =  "https://www.youtube.com/channel/UCRIdLxE7-YefPnNJOraYThQ" // Your Youtube ID here
        let appURL = NSURL(string: "\(YoutubeID)")!
        let webURL = NSURL(string: "\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    func playInYoutube(youtubeId: String) {
        if let youtubeURL = URL(string: "youtube://\(youtubeId)"),
            UIApplication.shared.canOpenURL(youtubeURL) {
            // redirect to app
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        } else if let youtubeURL = URL(string: "https://www.youtube.com/watch?v=\(youtubeId)") {
            // redirect through safari
            UIApplication.shared.open(youtubeURL, options: [:], completionHandler: nil)
        }
    }
 
}
extension AboutUSVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.labelNamesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardeCollectionCell", for: indexPath) as? DashboardeCollectionCell {

            customCell.labelName.text = labelNamesArray[indexPath.row]
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
extension AboutUSVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let object = labelNamesArray[indexPath.row]
        if indexPath.item == 0 || indexPath.item == 1 || indexPath.item == 2 || indexPath.item == 3 || indexPath.item == 4 || indexPath.item == 5 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let detailedVC = storyboard.instantiateViewController(withIdentifier: "AboutUSDetailedVC") as? AboutUSDetailedVC else { return }
            switch object {
            case AboutUs.introduction:
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            case AboutUs.historyOrigin:
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            case AboutUs.principle:
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            case AboutUs.pyramidDoctors:
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            case AboutUs.outlets:
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            case AboutUs.founder:
                let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
                guard let detailedVC = storyboard.instantiateViewController(withIdentifier: "AboutUsFounderVC") as? AboutUsFounderVC else { return }
                detailedVC.isComingAbout = object
                self.navigationController?.pushViewController(detailedVC, animated: false)
            default:
                break
            }
            
        }
    }
}

extension AboutUSVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}
extension UIApplication {
    class func tryURL(urls: [String]) {
        let application = UIApplication.shared
        for url in urls {
            if application.canOpenURL(URL(string: url)!) {
                application.openURL(URL(string: url)!)
                return
            }
        }
    }
}
