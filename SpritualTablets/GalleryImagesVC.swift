//
//  GalleryImagesVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 02/07/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class GallerySectionHeader: UICollectionReusableView {
   // @IBOutlet weak var sectionHeaderlabel: UILabel!
    var sectionHeaderlabel: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        sectionHeaderlabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.addSubview(sectionHeaderlabel)
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GalleryImagesVC: UIViewController {
    
    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!
    
    var galleryHeaderLabelArray = [String]()
    var galleryImagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        spinnerCreation(view: self.view, isStart: false)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        collectionVW.showsHorizontalScrollIndicator = false
        collectionVW.reloadData()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.collectionVW.register(GallerySectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GallerySectionHeader")
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var headerView = UICollectionReusableView()
        if kind == UICollectionView.elementKindSectionHeader {
            if let customHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GallerySectionHeader", for: indexPath as IndexPath) as? GallerySectionHeader {
                // customHeaderView.labelTitle.text = (indexPath.section == 0) ? kPrefferablePaymentMethod : kOtherPaymentMethod
                if indexPath.section == 0 {
                    customHeaderView.sectionHeaderlabel.text = self.galleryHeaderLabelArray[0]
                }
                if indexPath.section == 1 {
                    customHeaderView.sectionHeaderlabel.text = self.galleryHeaderLabelArray[1]
                }
                if indexPath.section == 2 {
                    customHeaderView.sectionHeaderlabel.text = self.galleryHeaderLabelArray[2]
                }
                if indexPath.section == 3 {
                    customHeaderView.sectionHeaderlabel.text = self.galleryHeaderLabelArray[3]
                }
                headerView = customHeaderView
            }
            headerView.backgroundColor = UIColor.blue
        }
        return headerView
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        let indexPath = IndexPath(row: 0, section: section)
//        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath) as! GallerySectionHeader
//        let a = UILabel.appearance(whenContainedInInstancesOf: [GallerySectionHeader.self])
//        headerView.sectionHeaderlabel.font = a.font
//        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        return CGSize(width: collectionView.frame.width, height: 40)
    }

}
extension GalleryImagesVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.galleryImagesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "AdmisionImagesCollectioncell", for: indexPath) as? AdmisionImagesCollectioncell {

            let data = self.galleryImagesArray[indexPath.row]
            customCell.cardView.layer.cornerRadius = 2
            customCell.cardView.layer.borderWidth = 1
            if let url = URL(string: data) {
                DispatchQueue.global().async {
                    guard let data2 = try? Data(contentsOf: url) else { return }
                    DispatchQueue.main.async {
                        customCell.imageItem.image = UIImage(data: data2)
                    }
                }
            }
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
extension GalleryImagesVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedItems = self.galleryImagesArray[indexPath.item]
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
