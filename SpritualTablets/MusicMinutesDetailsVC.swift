//
//  MusicMinutesDetailsVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 22/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class MusicMinutesDetailsVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var headerLabel: UILabel!

    var minustesDetailArray = [String]()
    
    var insideDetailsArr = [String]()
    var totalArrData = NSMutableDictionary()
    var productsData = NSMutableDictionary()
    
    var booksTotalData = [String]()
    var isMinutesKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getDetailedMusicData()
        headerLabel.text = "\(isMinutesKey)MIN MUSIC"
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
    
    func getDetailedMusicData() {
        Database.database().reference().child("Music").observe(.childAdded) { (snapshot) in
           // print("UserDataaaFound:\(snapshot.value! as Any)")
            let key = snapshot.key
           // guard let value = snapshot.value as? [String: Any] else { return }
           // print("UserDataaavalue:\(value)")
            if key == self.isMinutesKey {
//                if let details = value[key] as? NSDictionary {
//                    
//                    if let address = details["address"] as? String, let mobileNo = details["mobile_no"] as? String, let name = details["name"] as? String {
//                        
//                    }
//                }
                guard let value = snapshot.value as? [String: Any] else { return }
                for data in value {
                    let keyee = data.key
                    self.minustesDetailArray.append(keyee)
                }
                self.tblView.reloadData()
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.minustesDetailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        if let tblViewCell = tblView.dequeueReusableCell(withIdentifier: "BooksContentTblCell") as? BooksContentTblCell {
            tblViewCell.lblContentName.text = minustesDetailArray[indexPath.row]
            return tblViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }


}
