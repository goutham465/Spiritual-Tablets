//
//  AdmissionCenterDetailsVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 08/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class AdmissionCenterDetailsVC: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var heigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var colectionViewHeigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblView: UIView!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var reviewsTblView: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollVieww: UIScrollView!
    @IBOutlet weak var scrolCardView: UIView!
    @IBOutlet weak var scrolheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerName: UILabel!
    
    var dataArray = NSMutableDictionary()
    // String()
    var admisionName = ""
    var contactDetailsStr = ""
    var colectionImages = [String]()
    let edgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    var reviewNames = [String]()
    var reviewComents = [String]()
    var reviewStars = [String]()
    var dateDataArr = [String]()
    var tblCellCount: Int = 0
    var userLatitude = ""
    var userLongitude = ""
    var dateLabelData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.reviewsTblView.backgroundColor = .clear
        self.scrollVieww.delegate = self
        centerName.text = admisionName
        print(Auth.auth().currentUser?.metadata.creationDate ?? "")
        Database.database().reference().child("Admission Centers").observe(.childAdded) { (snapshot) in
            print("UserDataaaFound:\(snapshot.value! as Any)")
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else { return }
            print("UserDataaavalue:\(value)")
            if key == self.admisionName {
                if let details = value["Contact Details"] as? NSDictionary {
                    if let address = details["address"] as? String, let mobileNo = details["mobile_no"] as? String, let name = details["name"] as? String {
                        self.contactDetailsStr = "\(address)\(mobileNo)\(name)"
                        self.lblName.text = self.contactDetailsStr
                        let labelSize = self.lblName.getSize(constrainedWidth:self.lblName.frame.size.width)
                        self.heigthConstraint.constant = labelSize.height + 20.0
                    }
                }
                if  let displayImagesss = value["Images"] as? NSArray {
                    
//                    print(displayImagesss)
                   // if displayImagesss is NSArray {
                    displayImagesss.forEach({ element in
                        print(element)
                        if let valueee = element as? NSDictionary {
                            if let imageLinks = valueee.value(forKey: "link") as? String {
                                self.colectionImages.append(imageLinks)
                            }
                            self.collectionVW.reloadData()
                            let height = self.collectionVW.collectionViewLayout.collectionViewContentSize.height
                            let labelSize11 = self.collectionVW.getColetcionSize(constrainedWidth: self.collectionVW.frame.size.width)
                            self.colectionViewHeigthConstraint.constant = height
                        }

                    })
                }
                if  let locationValues = value["Location"] as? NSDictionary {
                    
                    if let latValue = locationValues["lat"] as? String, let longValue = locationValues["lon"] as? String {
                        self.userLatitude = latValue
                        self.userLongitude = longValue
                    }
                }
                if let reviews = value["Reviews"] as? NSDictionary {
                    reviews.forEach({ element in
                        print(element)
                        if let valueee = element.value as? NSDictionary {
                            print(valueee.count)
                            self.tblCellCount = valueee.count
                            self.reviewStars.append(String(valueee.value(forKey: "stars") as! Int))
                            print(self.reviewStars)
                            self.ratingView.rating = Double(valueee.value(forKey: "stars") as! Int)
                            self.reviewNames.append(valueee.value(forKey: "name") as! String)
                            if let coment = valueee.value(forKey: "comments") as? String {
                                self.reviewComents.append(coment)
                            }
                            if let dateTxt = valueee.value(forKey: "user_id") as? String {
                                self.dateDataArr.append(dateTxt)
                            }
                            print(self.dateDataArr)
                            self.reviewsTblView.isHidden = false
                            self.reviewsTblView.reloadData()
                         //   self.tblHeightConstraint.constant = self.reviewsTblView.contentSize.height
                          //  self.scrolheightConstraint.constant = 1000.0 //self.reviewsTblView.contentSize.height + self.view.frame.size.height
                          //  self.scrollVieww.contentSize = CGSize.init(width: self.scrollVieww.contentSize.width, height: self.reviewsTblView.contentSize.height + self.view.frame.size.height)
                        }

                    })
                } else {
                    self.reviewsTblView.isHidden = true
                }
            }
        }
        tblCellSetUp()
    }
    
    func tblCellSetUp() {
        reviewsTblView.register(UINib(nibName: "ReviewsTblCell", bundle: nil), forCellReuseIdentifier: "ReviewsTblCell")
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func wirteReviewBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let disController = storyboard.instantiateViewController(withIdentifier: "WriteReviewVC") as? WriteReviewVC {
            disController.admissionName = self.admisionName
            navigationController?.pushViewController(disController, animated: true)
        }
    }
    @IBAction func navigateToLocation(_ sender: UIButton) {
        
        if UIApplication.shared.canOpenURL(NSURL(string: "comgooglemaps://")! as URL) {
            UIApplication.shared.open(NSURL(string:
                                                "https://www.google.com/maps/dir/?api=1&origin=Current+Location&destination=\(self.userLatitude),\(self.userLongitude)&travelmode=driving")! as URL, options: [:], completionHandler: nil)
            
        } else {
            UIApplication.shared.open(NSURL(string:
                                                "https://www.google.com/maps/dir/?api=1&origin=Current+Location&destination=\(self.userLatitude),\(self.userLongitude)&travelmode=driving")! as URL, options: [:], completionHandler: nil)
        }
        
    }
//    func calculateSizeOfLabel(text:String,labelWidth:CGFloat,labelFont:UIFont)->CGSize{
//            let constrainedSize = CGSizeMake(labelWidth , 9999)
//
//            var attributesDictionary:[String:AnyObject] = [:]
//            attributesDictionary = [NSFontAttributeName:labelFont] as [String:AnyObject]
//            let string:NSMutableAttributedString = NSMutableAttributedString(string:text, attributes:attributesDictionary)
//            var boundingRect = string.boundingRectWithSize(constrainedSize, options:.usesLineFragmentOrigin, context:nil)
//            if (boundingRect.size.width > labelWidth) {
//                boundingRect = CGRectMake(0,0, labelWidth, boundingRect.size.height);
//            }
//        return boundingRect.size
//    }
}
class AdmisionImagesCollectioncell: UICollectionViewCell {

    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
}
extension AdmissionCenterDetailsVC: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.colectionImages.count
}

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdmisionImagesCollectioncell", for: indexPath) as? AdmisionImagesCollectioncell {

            let data = self.colectionImages[indexPath.item]
            customCell.cardView.layer.cornerRadius = 2
            customCell.cardView.layer.borderWidth = 1
            customCell.imageItem.dowloadFromServer(link: data, contentMode: .scaleAspectFill)
            cell = customCell
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

}
extension AdmissionCenterDetailsVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItems = self.colectionImages[indexPath.item]
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        if let disController = storyboard.instantiateViewController(withIdentifier: "ImageViewVC") as? ImageViewVC {
            disController.imageUrl = selectedItems
            navigationController?.pushViewController(disController, animated: true)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         let cellWidth = (collectionView.frame.width - 10)/3 // 363 width
         return CGSize(width: cellWidth, height: 90.0)
    }
}

extension UILabel {
    func getSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
extension UICollectionView {
    func getColetcionSize(constrainedWidth: CGFloat) -> CGSize {
        return systemLayoutSizeFitting(CGSize(width: constrainedWidth, height: UICollectionView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
extension AdmissionCenterDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.reviewStars.count
    }
       
       // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
       
       // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15.0
    }
       
       // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let tblViewCell = reviewsTblView.dequeueReusableCell(withIdentifier: "ReviewsTblCell") as? ReviewsTblCell {
            tblViewCell.viewBorder.layer.cornerRadius = 2
            tblViewCell.viewBorder.layer.borderWidth = 2
            tblViewCell.viewBorder.layer.borderColor = UIColor.white.cgColor
            tblViewCell.lblName.text = self.reviewNames[indexPath.section]
            if self.reviewComents.count > 0 {
                if (indexPath.section < self.reviewComents.count) {
                    tblViewCell.lblComments.text = self.reviewComents[indexPath.section]
                }
            }
            tblViewCell.ratingView.rating = Double(Int(self.reviewStars[indexPath.section]) ?? 0)
            let labelSize = tblViewCell.lblComments.getSize(constrainedWidth:tblViewCell.lblComments.frame.size.width)
           // tblViewCell.heigthConstraint.constant = labelSize.height
            return tblViewCell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
extension UIImageView {
    func dowloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, contentMode: mode)
    }
}
