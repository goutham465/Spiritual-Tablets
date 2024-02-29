//
//  BooksContentVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 21/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import SafariServices

enum LanguagesTypes: String {
    
    case telugu = "Telugu"
    case hindi = "Hindi"
    case english = "English"
    case tamil = "Tamil"
    case kannada = "Kannada"
    case gujarati = "Gujarathi"
    case marathi = "Marathi"
    
}

class BooksContentVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var headerLabel: UILabel!

    var booksDataArray = [String]()
    var insideDetailsArr = [String]()
    var totalArrData = NSMutableDictionary()
    var productsData = NSMutableDictionary()
    
    var booksTotalData = [String]()
    var isComingFrom = ""
    var languageSelect = ""
    
    var videoDateArray = [String]()
    var videoLinksArray = [String]()
    var videoNamesArray = [String]()
    
    var playerNameArray = [String]()
    var playerLinksArray = [String]()
    
    var booksReaderPdfArray = [String]()
    var booksReaderNamesArray = [String]()
    var docController: UIDocumentInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // getFirebaseData()
        getBooksTypesData()
        if isComingFrom == BookVary.audios {
           
            headerLabel.text = "AUDIOS"
            
        } else if isComingFrom == BookVary.books {
            headerLabel.text = "BOOKS"
        } else {
            
            headerLabel.text = "VIDEOS"
            tblView.register(UINib(nibName: "VideosTblCell", bundle: nil), forCellReuseIdentifier: "VideosTblCell")
        }
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        if isComingFrom == BookVary.books {
            self.navigationController?.popToRootViewController(animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    func openWeb(contentLink: String) {
        let url = URL(string: contentLink)!
        let controller = SFSafariViewController(url: url)
        controller.preferredBarTintColor = UIColor.darkGray
        controller.preferredControlTintColor = UIColor.groupTableViewBackground
        controller.dismissButtonStyle = .close
        controller.configuration.barCollapsingEnabled = true
        self.present(controller, animated: true, completion: nil)
        controller.delegate = self
    }
    
    func getFirebaseData() {
        spinnerCreation(view: self.view, isStart: true)
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("Books").observe(.value, with: { snapshot in
           // spinnerCreation(view: self.view, isStart: false)
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
                let value1 = valueD.value
                if keyD == self.isComingFrom {

                    print("The Key from the keyD: \(keyD)")
                    print("The Key value from Dict is: \(value1 ?? [])")
                    self.booksDataArray.append(keyD)
                    if let data = value1 ?? [] as? NSMutableDictionary {
                        self.totalArrData = data as! NSMutableDictionary
                    }
                    for temp in self.totalArrData  {
                        self.productsData.setValue(temp, forKey: keyD)
                    }
                    print("totalArrData:\(self.productsData)")
                    self.tblView.reloadData()
                    spinnerCreation(view: self.view, isStart: false)
                }
            }
        })

    }
    
    func getBooksTypesData() {
        spinnerCreation(view: self.view, isStart: true)
        if isComingFrom == BookVary.audios {
            
            Database.database().reference().child("Audios").observe(.childAdded) { (snapshot) in
                let key = snapshot.key
                print("Key Value:\(key)")
                guard let value = snapshot.value as? [String: Any] else { return }
               // print("Value:\(value)")
                if key == self.languageSelect {
                    
                    guard let value = snapshot.value as? [String: Any] else { return }
                    for data in value {
                        let keyee = data.key
                        self.booksTotalData.append(keyee)
                        if let details = value[keyee] as? NSDictionary {
                            print("PlayerDetails Count:\(details.count)")
                            if let links = details["link"] as? String, let name = details["name"] as? String {
                                
                                self.playerLinksArray.append(links)
                                self.playerNameArray.append(name)
                                
                            }
                        }
                        print("PlayerLinks Count:\(self.playerLinksArray.count)")
                        print("PlayerNames Count:\(self.playerLinksArray.count)")
                    }
                    self.tblView.reloadData()
                    spinnerCreation(view: self.view, isStart: false)
                }
                
            }
            
        } else if isComingFrom == BookVary.videos {
            
            Database.database().reference().child("Youtube").observe(.childAdded) { (snapshot) in
                let key = snapshot.key
                print("Key Value:\(key)")
                // guard let value = snapshot.value as? [String: Any] else { return }
                if key == self.languageSelect {
                    
                    guard let value = snapshot.value as? [String: Any] else { return }
                    for data in value {
                        let keyee = data.key
                        let valueeee = data.value
                        print("Key valueeee:\(valueeee)")
                        
                      //  self.booksTotalData.append(keyee)
                       // self.tblView.reloadData()
                        
                        if let details = value[keyee] as? NSDictionary {
                            if let date = details["date"] as? String, let links = details["link"] as? String, let name = details["name"] as? String {
                                
                                self.videoDateArray.append(date)
                                self.videoLinksArray.append(links)
                                self.videoNamesArray.append(name)
                                
                            }
                            self.tblView.reloadData()
                            spinnerCreation(view: self.view, isStart: false)
                        }
                    }
                    
                }
                
            }
        } else {
            Database.database().reference().child("Books").observe(.childAdded) { (snapshot) in
                let key = snapshot.key
                print("Key Value:\(key)")
                // guard let value = snapshot.value as? [String: Any] else { return }
                if key == self.languageSelect {
                    
                    guard let value = snapshot.value as? [String: Any] else { return }
                    for data in value {
                        let keyee = data.key
                        self.booksTotalData.append(keyee)
                        if let details = value[keyee] as? NSDictionary {
                            print("ReaderDetails Count:\(details.count)")
                            if let links = details["link"] as? String, let name = details["name"] as? String {
                                
                                self.booksReaderPdfArray.append(links)
                                self.booksReaderNamesArray.append(name)
                                
                            }
                        }
                        print("ReaderLinks Count:\(self.booksReaderPdfArray.count)")
                        print("ReaderNames Count:\(self.booksReaderNamesArray.count)")
                    }
                    self.tblView.reloadData()
                    spinnerCreation(view: self.view, isStart: false)
                }
                
            }
        }
    }
    func openDocument(name: String, type: String = "pdf", animated: Bool = true) {
        
        guard let path = Bundle.main.path(forResource: name, ofType: type) else { return }
        let targetURL = NSURL.fileURL(withPath: path)
        docController = UIDocumentInteractionController(url: targetURL)
        let url = NSURL(string: name)
        guard UIApplication.shared.canOpenURL(url! as URL) else { return }
        
        // if the code will be not in UIView/UIViewController write here self.addedProperty2ViewController.view instead view
        docController!.presentOpenInMenu(from: .zero, in: view, animated: animated)
    }
       
       // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isComingFrom == BookVary.videos {
            return self.videoNamesArray.count
        }
        return self.booksTotalData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isComingFrom == BookVary.videos {
            
            if let tblViewCell = tblView.dequeueReusableCell(withIdentifier: "VideosTblCell") as? VideosTblCell {
                tblViewCell.lblContentName.text = self.videoNamesArray[indexPath.row]
                // booksTotalData[indexPath.row]
                tblViewCell.lblVideoDate.text = self.videoDateArray[indexPath.row]
              //  self.lblName.text = self.contactDetailsStr
                let labelSize = tblViewCell.lblContentName.getSize(constrainedWidth:tblViewCell.lblContentName.frame.size.width)
                tblViewCell.heigthConstraint.constant = labelSize.height + 30.0
                tblViewCell.selectionStyle = .none
               // tblViewCell.btnContentLink.setImage(UIImage(named: "audio"), for: .normal)
                return tblViewCell
            }
            
        } else {
            if let tblViewCell = tblView.dequeueReusableCell(withIdentifier: "BooksContentTblCell") as? BooksContentTblCell {
                tblViewCell.lblContentName.text = booksTotalData[indexPath.row]
                if isComingFrom == BookVary.audios{
                    
                    tblViewCell.btnContentLink.setImage(UIImage(named: "audio"), for: .normal)
                } else {
                    tblViewCell.btnContentLink.setImage(UIImage(named: "book"), for: .normal)
                }
                tblViewCell.selectionStyle = .none
                return tblViewCell
            }
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isComingFrom == BookVary.videos {
            
            return 200.0
            // UITableView.automaticDimension
        }
        return 80.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        spinnerCreation(view: self.view, isStart: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            let object = self.booksTotalData[indexPath.row]
            if self.isComingFrom == BookVary.audios {
                let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
                if let disController = storyboard.instantiateViewController(withIdentifier: "AudioPlayerVC") as? AudioPlayerVC {
                    disController.playerName = object
                    if self.booksTotalData[indexPath.row] == self.playerNameArray[indexPath.row] {
                        
                        disController.playerLink = self.playerLinksArray[indexPath.row]
                    }
                    spinnerCreation(view: self.view, isStart: false)
                    self.navigationController?.pushViewController(disController, animated: true)
                }
            } else if self.isComingFrom == BookVary.books {
                if self.booksTotalData.count == self.booksReaderPdfArray.count {
                    spinnerCreation(view: self.view, isStart: false)
                    //  self.openDocument(name: self.booksReaderPdfArray[indexPath.row])
                //    disController.bookFileName = self.booksReaderPdfArray[indexPath.row]
                    self.openWeb(contentLink: self.booksReaderPdfArray[indexPath.row])
                }
                
                let storyboard = UIStoryboard(name: "SpritualTablets", bundle: nil)
//                if let disController = storyboard.instantiateViewController(withIdentifier: "BooksReaderView") as? BooksReaderView {
//                    if self.booksTotalData.count == self.booksReaderPdfArray.count {
//                        
//                        //  self.openDocument(name: self.booksReaderPdfArray[indexPath.row])
//                        disController.bookFileName = self.booksReaderPdfArray[indexPath.row]
//                    }
//                    disController.isRootFrom = BookVary.books
//                    spinnerCreation(view: self.view, isStart: false)
//                    self.navigationController?.pushViewController(disController, animated: true)
//                }
                
            } else {
                // Videos
            }
        }
    }

}
class BooksContentTblCell: UITableViewCell {
    
    @IBOutlet weak var lblContentName: UILabel!
    @IBOutlet weak var btnContentLink: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension BooksContentVC: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
