//
//  WeeklyQuotesVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 10/06/23.
//

import UIKit
import Firebase
import FirebaseDatabase
import WebKit

enum EventsType: String {
    
    case meditation = "Meditation"
    case workShops = "WorkShops"
    case anandhaoBrahmo = "Aanandho Brahma"
    
}

class EventTypesVC: UIViewController, WKUIDelegate {
  
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var heigthConstraint: NSLayoutConstraint!
    @IBOutlet weak var eventsTblView: UITableView!
    @IBOutlet weak var tblHeightConstraint: NSLayoutConstraint!
    var eventsName = ""
    var eventNameeeArr = ""
    var eventNameArray = [String]()
    var eventTimingArray = [String]()
    var eventDescriptionArr = [String]()
    var eventLinksArray = [String]()
    var eventImagesArray = [String]()
    var eventLink2Array = [String]()
 //   var dataArrObj = WorkshopEventsResponse()
    var mainStri = ""
    var isComingFrom = ""
    var youtubeId = ""
    var btnImageLink = ""
    
    var eventTimingssArr = ""
    var eventLinks2Arr = ""
    var eventImagesssArr = ""
    var webView = WKWebView()
    var dataArrObj = [WorkshopEventsResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 4
        borderView.layer.borderColor = UIColor.white.cgColor
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        if isComingFrom == EventsType.meditation.rawValue {
            eventsTblView.register(UINib(nibName: "EventsTblCell", bundle: nil), forCellReuseIdentifier: "EventsTblCell")
            eventsTblView.rowHeight = UITableView.automaticDimension
        } else if isComingFrom == EventsType.workShops.rawValue {
            
            eventsTblView.register(UINib(nibName: "WorkShopsEventTypeCell", bundle: nil), forCellReuseIdentifier: "WorkShopsEventTypeCell")
            eventsTblView.rowHeight = UITableView.automaticDimension
            
        } else {
            eventsTblView.register(UINib(nibName: "EventsType2Cell", bundle: nil), forCellReuseIdentifier: "EventsType2Cell")
            eventsTblView.rowHeight = UITableView.automaticDimension
        }
        self.getFireBaseData()
       // self.eventsTblView.reloadData()
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getFireBaseData() {
        spinnerCreation(view: self.view, isStart: true)
        
        let ref111 = Database.database().reference()
        print(ref111)
        ref111.child("events").observe(.value, with: { snapshot in
            
            self.dataArrObj.removeAll()
            
            for child in snapshot.children {
                let valueD = child as! DataSnapshot
                let keyD = valueD.key
               // let value1 = valueD.value
               // print("The Key from the keyD: \(keyD)")
               // print("The Key value from Dict is: \(value1 ?? [])")
                guard let value = valueD.value as? [String: Any] else { return }
              //  print("The Key value from Dict is: \(value)")
                
                if keyD == self.eventsName {
                    // if let reviews = value[self.eventsName] as? NSDictionary {
                    value.forEach({ element in
                        print("EachElement:\(element)")
                        if let valueee = element.value as? NSDictionary {
                            print(valueee.count)
                            if valueee.value(forKey: "name") != nil {
                                self.eventNameArray.append(valueee.value(forKey: "name") as! String)
                                self.eventNameeeArr.append(valueee.value(forKey: "name") as! String)
                            }
                            if valueee.value(forKey: "timing") != nil {
                                let trimStr = valueee.value(forKey: "timing") as! String
                                let swiftyString = trimStr.replacingOccurrences(of: " ", with: "")
                                self.eventTimingArray.append(swiftyString)
                                self.eventTimingssArr.append(swiftyString)
                            }
                            if valueee.value(forKey: "link") != nil {
                                self.eventLinksArray.append(valueee.value(forKey: "link") as! String)
                            }
                            if valueee.value(forKey: "description") != nil {
                                self.eventDescriptionArr.append(valueee.value(forKey: "description") as! String)
                            }
                            if valueee.value(forKey: "image1") != nil {
                                self.eventImagesArray.append(valueee.value(forKey: "image1") as! String)
                                self.eventImagesssArr.append(valueee.value(forKey: "image1") as! String)
                            }
                            if let data = valueee.value(forKey: "link2") as? String {
                                self.eventLink2Array.append(data)
                                self.eventLinks2Arr.append(data)
                            }
                            print("EventLinks2:\(self.eventLink2Array)")
                            print(self.eventNameArray.count)
                            print(self.eventTimingArray.count)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                spinnerCreation(view: self.view, isStart: false)
                                self.eventsTblView.reloadData()
                            }
                            
                        }
                        
                    })
                    let object = WorkshopEventsResponse.init(eventName: self.eventNameeeArr, timing: self.eventTimingssArr, links2: self.eventLinks2Arr, images: self.eventImagesssArr )
                    self.dataArrObj.append(object)
                    print("Object Data:\(self.dataArrObj)")
                }
            }
        })
        Database.database().reference().child("events").observe(.childAdded) { (snapshot) in
          //  print("UserDataaaFound:\(snapshot.value! as Any)")
            let key = snapshot.key
            guard let value = snapshot.value as? [String: Any] else { return }
           // print("UserDataaavalue:\(value)")
//            if key == self.eventsName {
//                // if let reviews = value[self.eventsName] as? NSDictionary {
//                value.forEach({ element in
//                    print("EachElement:\(element)")
//                    if let valueee = element.value as? NSDictionary {
//                        print(valueee.count)
//                        if valueee.value(forKey: "name") != nil {
//                            self.eventNameArray.append(valueee.value(forKey: "name") as! String)
//                        }
//                        if valueee.value(forKey: "timing") != nil {
//                            self.eventTimingArray.append(valueee.value(forKey: "timing") as! String)
//                        }
//                        if valueee.value(forKey: "link") != nil {
//                            self.eventLinksArray.append(valueee.value(forKey: "link") as! String)
//                        }
//                        if valueee.value(forKey: "description") != nil {
//                            self.eventDescriptionArr.append(valueee.value(forKey: "description") as! String)
//                        }
//                        if valueee.value(forKey: "image1") != nil {
//                            self.eventImagesArray.append(valueee.value(forKey: "image1") as! String)
//                        }
//                        if valueee.value(forKey: "link2") != nil {
//                            self.eventLink2.append(valueee.value(forKey: "link2") as! String)
//                        }
//                     //   self.dataArrObj = EventsResponse(name: valueee.value(forKey: "name") as! String,timing: valueee.value(forKey: "timing") as! String, links: valueee.value(forKey: "link") as! String, description: valueee.value(forKey: "description") as! String, links2: valueee.value(forKey: "link2") as! String, images: valueee.value(forKey: "image1") as! String)
//                        print(self.eventNameArray.count)
//                        print(self.eventTimingArray.count)
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
//                            // spinnerCreation(view: self.view, isStart: false)
//                            self.eventsTblView.reloadData()
//                        }
//
//                    }
//
//                })
//            }
        }
    }
    
    @objc func youtubeAction() {

        let YoutubeID =  youtubeId // Your Youtube ID here
        let appURL = NSURL(string: "youtube://www.youtube.com/watch?v=\(YoutubeID)")!
        let webURL = NSURL(string: "https://www.youtube.com/watch?v=\(YoutubeID)")!
        let application = UIApplication.shared

        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }

    }
    @objc func btnImageLinkAction() {
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
        let url = URL(string: btnImageLink)
        let request = URLRequest(url: url!)
        webView.load(request)
        
    }

}
extension EventTypesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isComingFrom == EventsType.anandhaoBrahmo.rawValue {
            return self.eventNameArray.count
        } else if isComingFrom == EventsType.meditation.rawValue {
            return self.eventNameArray.count
        } else {
           // let data = WorkshopEventsResponse.count
            return self.eventImagesArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isComingFrom == EventsType.anandhaoBrahmo.rawValue {
            if let tblCell = eventsTblView.dequeueReusableCell(withIdentifier: "EventsType2Cell") as? EventsType2Cell {
                tblCell.lblEventName.text = self.eventNameArray[indexPath.row]
                tblCell.lblEventTiming.text = self.eventTimingArray[indexPath.row]
                tblCell.lblEventDescription.text = self.eventDescriptionArr[indexPath.row]
                tblCell.btnEventLink.setTitle(self.eventLinksArray[indexPath.row], for: .normal)
                youtubeId = self.eventLinksArray[indexPath.row]
                tblCell.btnEventLink.addTarget(self, action: #selector(self.youtubeAction), for: .touchUpInside)
              //  tblCell.heigthConstraint.constant = tblCell.viewBorder.frame.size
               // tblCell.adjustsFontForContentSizeCategory = true
              
                return tblCell
            }
        } else if isComingFrom == EventsType.meditation.rawValue {
            if let tblCell = eventsTblView.dequeueReusableCell(withIdentifier: "EventsTblCell") as? EventsTblCell {
                tblCell.lblEventName.text = self.eventNameArray[indexPath.row]
                tblCell.lblEventTiming.text = self.eventTimingArray[indexPath.row]
                self.mainStri = "\("Event Name")\(tblCell.lblEventName.text)\("Event Timing:")\(tblCell.lblEventTiming.text)"
                // tblCell.lblEventName.text = self.mainStri
                let labelSize = tblCell.lblEventTiming.getSize(constrainedWidth:tblCell.lblEventTiming.frame.size.width)
                let labelSize2 = tblCell.lblEventName.getSize(constrainedWidth:tblCell.lblEventName.frame.size.width)
                //  tblCell.contentView.frame.size.height = tblCell.viewBorder.frame.size.height - labelSize.height - labelSize2.height
                //  tblCell.heigthConstraint.constant = tblCell.contentView.frame.size.height
                // tblCell.viewBorder.frame.size.height - labelSize.height - labelSize2.height
                
                return tblCell
            }
        } else {
            // Workshopss
            if let tblCell = eventsTblView.dequeueReusableCell(withIdentifier: "WorkShopsEventTypeCell") as? WorkShopsEventTypeCell {
//                if(self.eventImagesArray[indexPath.row] == self.eventLink2Array[indexPath.row]) {
//                    
//                    tblCell.btnEventLink.setTitle(self.eventLink2Array[indexPath.row], for: .normal)
//                    youtubeId = self.eventLink2Array[indexPath.row]
//                    tblCell.btnEventLink.addTarget(self, action: #selector(self.youtubeAction), for: .touchUpInside)
//                    
//                } else {
//                    
//                    tblCell.btnEventLink.setTitle(self.eventLink2Array[indexPath.row], for: .normal)
//                    youtubeId = self.eventLink2Array[indexPath.row]
//                    tblCell.btnEventLink.addTarget(self, action: #selector(self.youtubeAction), for: .touchUpInside)
//                    
//                }
                if(indexPath.row < eventLink2Array.count) {
                    
                    tblCell.btnEventLink.setTitle(self.eventLink2Array[indexPath.row], for: .normal)
                    youtubeId = self.eventLink2Array[indexPath.row]
                    tblCell.btnEventLink.addTarget(self, action: #selector(self.youtubeAction), for: .touchUpInside)
                }
                tblCell.btnImageLink.tag = indexPath.row
                tblCell.btnEventLink.tag = indexPath.row
                tblCell.lblEventName.text = self.eventNameArray[indexPath.row]
                tblCell.lblEventTiming.text = self.eventTimingArray[indexPath.row]
                let data = self.eventImagesArray[indexPath.row]
                btnImageLink = self.eventImagesArray[indexPath.row]
                if let url = URL(string: data) {
                    DispatchQueue.global().async {
                        guard let data2 = try? Data(contentsOf: url) else { return }
                        DispatchQueue.main.async {
                            tblCell.eventImage.image = UIImage(data: data2)
                           // tblCell.btnImageLink.setImage(UIImage(data: data2), for: .normal)
                            
                        }
                    }
                }
                tblCell.btnImageLink.addTarget(self, action: #selector(self.btnImageLinkAction), for: .touchUpInside)
                return tblCell
            }
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isComingFrom == EventsType.anandhaoBrahmo.rawValue {
            return 650.0
            // UITableView.automaticDimension
        } else if isComingFrom == EventsType.meditation.rawValue {
            return 260.0
        } else {
            return 950.0
        }
    }
}

struct WorkshopEventsResponse {
    var eventName: String?
    var timing: String?
    var links2: String?
    var images: String?
}
