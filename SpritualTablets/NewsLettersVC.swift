//
//  NewsLettersVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/05/23.
//

import UIKit
import Firebase
import FirebaseDatabase

class NewsLettersVC: UIViewController {

    @IBOutlet weak var collectionVW: UICollectionView!
    @IBOutlet weak var musicBorderView: UIView!

    var newsLettersArray = [String]()
    var labelNamesArray = ["AUGUST 2022", "SEPTEMBER 2022", "SEPTEMBER 2016", "MAY 2016", "JANUARY 2016", "OCTOBER 2015", "AUGUST 2015", "JULY 2015", "APRIL 2015", "JANUARY 2015", "SEPTEMBER 2014", "JULY 2014", "FEBRUARY 2014", "APRIL 2013", "MAY 2013", "JULY 2013", "DECEMBER 2012"]

    override func viewDidLoad() {
        super.viewDidLoad()
        getFirebaseData()
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
    func getFirebaseData() {
        spinnerCreation(view: self.view, isStart: true)
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("News Letters").observe(.value, with: { snapshot in
            spinnerCreation(view: self.view, isStart: false)
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
                print("The Key from the keyD: \(keyD)")
                print("The Key value from Dict is: \(value1 ?? [])")
                self.newsLettersArray.append(keyD)
                self.collectionVW.reloadData()
            }
        })

    }
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "Spritiual Tablets-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                print("pdf successfully saved!")
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
 
}
extension NewsLettersVC: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.labelNamesArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        var cell = UICollectionViewCell()
        if let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardeCollectionCell", for: indexPath) as? DashboardeCollectionCell {

            customCell.labelName.text = labelNamesArray[indexPath.row].uppercased()
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
extension NewsLettersVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            let url = URL(string: "https://pssm.createsend.com/t/ViewEmail/j/BC55DC689591CD19/C67FD2F38AC4859C/")
            UIApplication.shared.open(url!, options: [:])
            savePdf(urlString: "https://pssm.createsend.com/t/ViewEmail/j/BC55DC689591CD19/C67FD2F38AC4859C/", fileName: "August2022")
        }
        if indexPath.item == 1 {
            let url = URL(string: "http://pssm.cmail20.com/t/ViewEmail/j/5F154942F8F1C9AF")
            UIApplication.shared.open(url!, options: [:])
            savePdf(urlString: "http://pssm.cmail20.com/t/ViewEmail/j/5F154942F8F1C9AF", fileName: "Septmeber2022")
        }
        if indexPath.item == 2 {
            let url = URL(string: "https://pssm.createsend.com/t/ViewEmail/j/BC55DC689591CD19/C67FD2F38AC4859C/")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 3 {
            let url = URL(string: "http://pssm.cmail20.com/t/ViewEmail/j/5F154942F8F1C9AF")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 4 {
            let url = URL(string: "http://pssm.cmail20.com/t/ViewEmail/j/EFA3E689FA61EBA8")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 5 {
            let url = URL(string: "http://pssm.cmail2.com/t/ViewEmail/j/2D5732E2A7F2D379")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 6 {
            let url = URL(string: "http://pssm.cmail2.com/t/ViewEmail/j/2075529D26AD6F5A")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 7 {
            let url = URL(string: "https://pssm.createsend1.com/t/ViewEmail/j/CC28E4B84FC62108")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 8 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=01FDF1C41DEBE889&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 9 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=CA465937085D868B&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 10 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=214BE9659DBAEF9D&temp=Falsee")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 11 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=AE5453F12DC9BE0A&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 12 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=02434440C7F95B81&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 13 {
            let url = URL(string: "https://phsc.createsend4.com/t/ViewEmail/t/7EAFAE749423D972")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 14 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=8A4ED2DE64EBDE4F&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 15 {
            let url = URL(string: "https://pssm.createsend.com/campaigns/reports/viewCampaign.aspx?d=j&c=B70A9281B84B04D3&ID=586BBFE397B97AFD&temp=False")
            UIApplication.shared.open(url!, options: [:])
        }
        if indexPath.item == 16 {
            let url = URL(string: "https://pssm.createsend.com/t/ViewEmail/t/3BEE6D26863BA124/C67FD2F38AC4859C/")
            UIApplication.shared.open(url!, options: [:])
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
}

extension NewsLettersVC: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 10 )/2
        return CGSize(width: cellWidth, height: 110.0)
    }
}

