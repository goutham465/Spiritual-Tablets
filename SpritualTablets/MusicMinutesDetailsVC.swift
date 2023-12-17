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
    var musicMinuteNamesArray = [String]()
    var musicMinutesLinkArray = [String]()

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
            let key = snapshot.key
            if key == self.isMinutesKey {
                guard let value = snapshot.value as? [String: Any] else { return }
                for data in value {
                    let keyee = data.key
                    self.minustesDetailArray.append(keyee)
                    if let details = value[keyee] as? NSDictionary {
                        print("Misuc Minutes Count:\(details.count)")
                        if let links = details["link"] as? String, let name = details["name"] as? String {
                            
                            self.musicMinutesLinkArray.append(links)
                            self.musicMinuteNamesArray.append(name)
                            
                        }
                    }
                    print("Misuc Minutes Count:\(self.musicMinutesLinkArray.count)")
                    print("Misuc Minutes11 Count:\(self.musicMinuteNamesArray.count)")
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
            tblViewCell.selectionStyle = .none
            return tblViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spinnerCreation(view: self.view, isStart: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let object = self.minustesDetailArray[indexPath.row]
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            if let disController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerVC") as? AudioPlayerVC {
                disController.playerName = object
                if self.minustesDetailArray[indexPath.row] == self.musicMinuteNamesArray[indexPath.row] {
                    
                    disController.playerLink = self.musicMinutesLinkArray[indexPath.row]
                }
                spinnerCreation(view: self.view, isStart: false)
                self.navigationController?.pushViewController(disController, animated: true)
            }
        }
    }
    
}
