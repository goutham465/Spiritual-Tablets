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
    @IBOutlet weak var sectionHeaderlabel: UILabel!
}

class GalleryImagesVC: UIViewController {
    
    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!
    
    var galleryHeaderLabelArray = [String]()
    var galleryImagesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  getFirebaseData()
      //  self.galleryDbRetrieve()
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
    func getFirebaseData() {
      //  spinnerCreation(view: self.view, isStart: true)
        Database.database().reference().child("gallery").observe(.childAdded) { (snapshot) in
           // spinnerCreation(view: self.view, isStart: false)
            let key = snapshot.key
            print("Key Value:\(key)")
            guard let value = snapshot.value as? NSArray else { return }
            self.galleryHeaderLabelArray.append(key)
            print("SnapShot Value:\(String(describing: snapshot.value))")
            for rowIndex in value {
                if let rowVal = rowIndex as? String {
                    self.galleryImagesArray.append(rowVal)
                }
            }
            self.collectionVW.register(GallerySectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GallerySectionHeader")
            self.collectionVW.reloadData()
            
          //  guard snapshot.value is [String: Any] else { return }
            //  if key == self.languageSelect {
            
        //    guard let value = snapshot.value(forKey: key) as? NSArray else { return }
            
//            for data in value {
//              //  let keyee = data.key
//                self.galleryHeaderLabelArray.append(data)
//                if let details = value[keyee] as? NSArray {
//                    print("ImagesCount:\(details.count)")
//                    if let imageLinks = details.value(forKey: keyee) as? String {
//                        self.galleryImagesArray.append(imageLinks)
//                    }
//                }
//                // self.tblView.reloadData()
//                //  }
//                self.collectionVW.reloadData()
//            }
           // self.collectionVW.reloadData()
           // self.collectionVW.register(GallerySectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "GallerySectionHeader")
        }
    }
//    func galleryDbRetrieve() {
//        spinnerCreation(view: self.view, isStart: true)
//        let galleryRef = Database.database().reference()
//        print(galleryRef)
//        galleryRef.child("gallery").observe(.value, with: { snapshot in
//            for child in snapshot.children {
//                let valueD = child as! DataSnapshot
//                let keyD = valueD.key
//                let value1 = valueD.value
//                print("The Gallery Key from the keyD: \(keyD)")
//                print("The Gallery value from the: \(String(describing: value1))")
//                self.galleryHeaderLabelArray.append(keyD)
//                // print("The value from the keyD: \(value1)")
//                guard let valueImage = value1 as? NSArray else {return}
//                for rowIndex in valueImage {
//                    if let imgUrl = rowIndex as? String {
//                        self.galleryImagesArray.append(imgUrl)
//                    }
//                }
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
//                    spinnerCreation(view: self.view, isStart: false)
//                    self.collectionVW.reloadData()
//                }
//            }
//        })
//    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "GallerySectionHeader", for: indexPath) as? GallerySectionHeader{
          //  sectionHeader.sectionHeaderlabel.text = self.galleryHeaderLabelArray[indexPath.row]
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
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

            let data = self.galleryImagesArray[indexPath.item]
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
