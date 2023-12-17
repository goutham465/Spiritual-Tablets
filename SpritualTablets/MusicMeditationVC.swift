//
//  MusicMeditationVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/05/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class MusicMeditationVC: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!

    var musicMinutesArray = [String]()
    var labelNamesArray = ["5 MINUTES", "10 MINUTES", "15 MINUTES", "20 MINUTES", "30 MINUTES", "40 MINUTES", "50 MINUTES", "60 MINUTES", "75 MINUTES", "90 MINUTES"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getFirebaseData()
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        collectionVW.showsHorizontalScrollIndicator = false
      //  collectionVW.reloadData()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)

    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getFirebaseData() {
        spinnerCreation(view: self.view, isStart: true)
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("Music").observe(.value, with: { snapshot in
            spinnerCreation(view: self.view, isStart: false)
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
                print("The Key from the keyD: \(keyD)")
                print("The Key value from Dict is: \(value1 ?? [])")
                self.musicMinutesArray.append(keyD)
                self.collectionVW.reloadData()
            }
        })

    }
 
}
extension MusicMeditationVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.musicMinutesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardeCollectionCell", for: indexPath) as? DashboardeCollectionCell {
            let textFont = UIFont(name: "Antic-Bold", size: 16.0)
            customCell.labelName.font = textFont
            customCell.labelName.text = "\(musicMinutesArray[indexPath.row]) MINUTES"
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
extension MusicMeditationVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        let data = self.musicMinutesArray[indexPath.item]
        let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
        guard let musicVC = storyboard.instantiateViewController(withIdentifier: "MusicMinutesDetailsVC") as? MusicMinutesDetailsVC else { return }
        musicVC.isMinutesKey = data
        self.navigationController?.pushViewController(musicVC, animated: false)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
}

extension MusicMeditationVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}

