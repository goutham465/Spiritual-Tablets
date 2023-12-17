//
//  AdmissionCentersVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 08/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase


class AdmissionCentersVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var borderView: UIView!

    var admisionCenteresDataArray = [String]()
    var insideDetailsArr = [String]()
    var totalArrData = NSMutableDictionary()
    var productsData = NSMutableDictionary()
  //  [[String: Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getFirebaseData()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        tblView.register(UINib(nibName: "AdmissionsTblCell", bundle: nil), forCellReuseIdentifier: "AdmissionsTblCell")
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getFirebaseData() {
        spinnerCreation(view: self.view, isStart: true)
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("Admission Centers").observe(.value, with: { snapshot in
            spinnerCreation(view: self.view, isStart: false)
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
                print("The Key from the keyD: \(keyD)")
                print("The Key value from Dict is: \(value1 ?? [])")
                self.admisionCenteresDataArray.append(keyD)
                if let data = value1 ?? [] as? NSMutableDictionary {
                    self.totalArrData = data as! NSMutableDictionary
                }
                for temp in self.totalArrData  {
                    self.productsData.setValue(temp, forKey: keyD)
                }
                print("totalArrData:\(self.productsData)")
                self.tblView.reloadData()
                for grandchild in (child as AnyObject).children {
                    let valueD = grandchild as! DataSnapshot
                    let keyD = valueD.key
                    let value1 = valueD.value
                    //  print(keyD)
                    print("The Key-value from the keyD2: \(keyD)")
                    print("The Key-value11 from the keyD3: \(value1)")
                }
            }
        })
        
        Database.database().reference().child("Admission Centers").observe(.childAdded) { (snapshot) in
            print("UserDataaaFound:\(snapshot.value! as Any)")
          // admisionCenteresArray.append(snapshot.value as Any)
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else { return }
            print("UserDataaavalue:\(value)")
            if let details = value["Contact Details"] as? NSDictionary {
                if let address = details["address"] as? String, let mobileNo = details["mobile_no"] as? String, let name = details["name"] as? String {
                    
                }
            }
        }
        let totalConatctDetails = "\("")\("")\("")"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.admisionCenteresDataArray.count
    }
       
       // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
       
       // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
       
       // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tblViewCell = tblView.dequeueReusableCell(withIdentifier: "AdmissionsTblCell") as? AdmissionsTblCell {
            tblViewCell.viewBorder.layer.cornerRadius = 4
            tblViewCell.viewBorder.layer.borderWidth = 1
            tblViewCell.viewBorder.layer.borderColor = UIColor.white.cgColor
            tblViewCell.lblName.text = admisionCenteresDataArray[indexPath.section]
            
            return tblViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            if let disController = storyboard.instantiateViewController(withIdentifier: "AdmissionCenterDetailsVC") as? AdmissionCenterDetailsVC {
                let object = self.admisionCenteresDataArray[indexPath.section]
                disController.admisionName = object
                
                if indexPath.row == 0 {
                }
                navigationController?.pushViewController(disController, animated: true)
            }
    }

}

