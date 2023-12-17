//
//  ContactUSVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 18/05/23.
//

import UIKit

class ContactUSVC: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var officeTextView: UIView!
    @IBOutlet weak var officeViewAlert: UIView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var developerView: UIView!
    @IBOutlet weak var developerViewAlert: UIView!
    
    var labelNamesArray = ["RESGISTERED OFFICE", "PRIMARY CENTERS", "ADMISSION CENTERS", "VIRTUAL WELLNESS CENTERS"]
    var contactDetailsStr = ""

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
        tblView.dataSource = self
        tblView.delegate = self
        tblView.layer.backgroundColor = UIColor.white.cgColor
        tblView.layer.borderColor = UIColor.white.cgColor
        tblView.layer.cornerRadius = 2
        tblView.layer.borderWidth = 0.5
        tblView.reloadData()
        tblView.rowHeight = UITableView.automaticDimension
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.officeTextView.tag == 100 {
            self.officeTextView.isHidden = true
            self.developerView.isHidden = true
        }
    }
    @IBAction func developerBtnAction(_ sender: UIButton) {
        
        self.developerView.isHidden = false
        developerView.frame.size.width = self.view.frame.size.width
        developerView.frame.size.height = self.view.frame.size.height
        self.view.addSubview(developerView)
    }
 
}
extension ContactUSVC: UICollectionViewDataSource {

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
extension ContactUSVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        if indexPath.item == 0 {
            self.officeTextView.isHidden = false
            officeTextView.frame.size.width = self.view.frame.size.width
            officeTextView.frame.size.height = self.view.frame.size.height
            self.view.addSubview(officeTextView)
        } else if indexPath.item == 1 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "ContactPrimaryCentersVC") as? ContactPrimaryCentersVC else { return }
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        } else if indexPath.item == 2 {
            guard let admissionCentersVc = self.storyboard?.instantiateViewController(withIdentifier: "AdmissionCentersVC") as? AdmissionCentersVC else { return }
            self.navigationController?.pushViewController(admissionCentersVc, animated: false)
        } else if indexPath.item == 3 {
            let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
            guard let meditaionVC = storyboard.instantiateViewController(withIdentifier: "VirtualWellnessCentersVC") as? VirtualWellnessCentersVC else { return }
            self.navigationController?.pushViewController(meditaionVC, animated: false)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
}

extension ContactUSVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}
extension ContactUSVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let checkBoxCell = tblView.dequeueReusableCell(withIdentifier: "AboutDetailedTblCell", for: indexPath)  as? AboutDetailedTblCell {
            checkBoxCell.selectionStyle = .none
            contactDetailsStr = "IF YOU ARE CONTACTING FOR:\n\n1.1.USA (EAST COAST):\n\n  +1(862)215-1492\n+1(302)465-5446\n\n2.USA (WEST COAST):\n\n+1(480)228-9111\n +1(303)718-7525\n\n3.NORTH INDIA:\n\n+918802210022\n\n4.SOUTH INDIA:\n\n+919246648402\n\n5.PORTUGAL:\n\n+351 910 760 485\n\n6.MALAYSIA:\n\n+60 13-606 2832\n\n7.SINGAPORE:\n\n+65 9187 5582\n+65 9187 5575\n\n8.AUSTRALIA:\n\n+61 470 591 674\n+61 411 275 497\n\n9.DUBAI:\n\n+971 50 134 2950\n\n10.QATAR:\n\n+974 5541 7885\n\n11.EUROPE:\n\n00447459180895\n\n12.UNITED KINGDOM:\n\n+44 7513 036598\n\n13.FRANCE:\n\n+33 781 55 66 36\n\n14.GERMANY:\n\n+49 1522 6662948\n\n15.NEPAL:\n\n+1 (551) 208-4839\n\n16.VIETNAM:\n\n+84 94 718 11 07\n\n17.KENYA:\n\n+254 780 405309"
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
            tblView.rowHeight = labelSize.height + 30.0
            return checkBoxCell
        }
        return UITableViewCell()
    }
}
