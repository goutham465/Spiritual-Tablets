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
    
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
}

extension AboutUSVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}
