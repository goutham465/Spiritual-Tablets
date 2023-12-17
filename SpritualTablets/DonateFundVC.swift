//
//  DonateFundVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 31/07/23.
//

import UIKit
import WebKit
import SafariServices

class DonateFundVC: UIViewController, WKUIDelegate {

    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var donateNowBtn: UIButton!
    var contactDetailsStr = ""
    var webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        tblView.dataSource = self
        tblView.delegate = self
        tblView.reloadData()
        tblView.rowHeight = UITableView.automaticDimension
        donateNowBtn.layer.cornerRadius = 4
        donateNowBtn.layer.borderWidth = 0.2
        donateNowBtn.layer.backgroundColor = UIColor.white.cgColor
    }
    

    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func donateBtnAction(_ sender: UIButton) {
        self.openWeb(contentLink: "https://payu.in/pay/A381DF3EC1177559CC7B5B2440F3DC67")
    }
    func openWeb(contentLink : String) {
        let url = URL(string: contentLink)!
        let controller = SFSafariViewController(url: url)
        controller.preferredBarTintColor = UIColor.darkGray
        controller.preferredControlTintColor = UIColor.groupTableViewBackground
        controller.dismissButtonStyle = .close
        controller.configuration.barCollapsingEnabled = true
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }

}
extension DonateFundVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let checkBoxCell = tblView.dequeueReusableCell(withIdentifier: "AboutDetailedTblCell", for: indexPath)  as? AboutDetailedTblCell {
            checkBoxCell.selectionStyle = .none
            contactDetailsStr = "Your Greatness is Not What you Have, It’s What You Give.\n\nWhile the workshops and counselling are free of cost, the organization incurs sizeable expenditure on the following counts:\n\n1.Maintenance of website\n2.Publishing and translation of books in different languages\n3.Conducting online sessions for the benefit of the Western world.\n4.Conversion of spiritual tablets modules into PDF and audiovisual modes\n5.Cultural programs, travel of the faculty and establishment of new centres\n\nWe request, one and all, to avail this divine opportunity by showering donations liberally and reap the benefits of this virtuous deed. Our deepest gratitude, in advance."
            checkBoxCell.detailedStr.text = self.contactDetailsStr
            let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
            tblView.rowHeight = labelSize.height + 20.0
            return checkBoxCell
        }
        return UITableViewCell()
    }
}
extension DonateFundVC: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
