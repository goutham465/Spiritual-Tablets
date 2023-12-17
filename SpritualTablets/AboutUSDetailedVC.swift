//
//  AboutUSDetailedVCViewController.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 24/07/23.
//

import UIKit

class AboutUs {
   
    static let introduction = "INTRODUCTION"
    static let historyOrigin = "HISTORY & ORIGIN"
    static let principle = "PRINCIPLE"
    static let pyramidDoctors = "PYRAMID DOCTORS"
    static let outlets = "OUTLETS"
    static let founder = "FOUNDER"
}

class AboutUSDetailedVC: UIViewController {
    
    var isComingAbout = ""
    @IBOutlet weak var musicBorderView: UIView!
    @IBOutlet weak var labelStr: UILabel!
    @IBOutlet var alertHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollVieww: UIScrollView!
    @IBOutlet weak var scrolCardView: UIView!
    @IBOutlet weak var scrolheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var detailedStr: UILabel!
    @IBOutlet weak var founderLblStr: UILabel!
    @IBOutlet weak var founderImage: UIImageView!
    @IBOutlet weak var tblView: UITableView!
    var contactDetailsStr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        musicBorderView.layer.cornerRadius = 10
        musicBorderView.layer.borderWidth = 4
        musicBorderView.layer.borderColor = UIColor.white.cgColor
        tblView.dataSource = self
        tblView.delegate = self
        tblView.reloadData()
        tblView.rowHeight = UITableView.automaticDimension
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}

class AboutDetailedTblCell: UITableViewCell {
    @IBOutlet weak var detailedStr: UILabel!
    
}
extension AboutUSDetailedVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView (_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

       return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let checkBoxCell = tblView.dequeueReusableCell(withIdentifier: "AboutDetailedTblCell", for: indexPath)  as? AboutDetailedTblCell {
            checkBoxCell.selectionStyle = .none
            if isComingAbout == AboutUs.introduction {
                labelStr.text = isComingAbout
                contactDetailsStr = "The world has become too materialistic and sadly we live in it, forgetting about nature. Society we live in got familiarize to mechanical life resultantly, lameness has spread in varied forms affecting a person's body, mind, spirit and social well-being that is leading to inadequacy of peace, pleasure and happiness. In order to decimate this 'Brahmastra', a holistic health approach, was incorporated by name SPIRITUAL TABLETS. During the past 12 years a lot of research has been done and now, foundation which was started with an aim to serve all is a pride for the world.\n\nIn the last 6 years, a group of spiritual counselors and volunteers, under the guidance of Dr. Gopala Krishna has developed 350 spiritual tablets in the form of text, audio and audio visuals. These Spiritual Concepts will change our internal belief system, that help us to transpose ourselves in order to open to the universe for its guidance in all circumstances.\n\nWe conducted various training workshops which lead to the treasury of spiritual health care centers throughout the world, trained multiple cases teaching meditation, spiritual counseling, spiritual guidance and spiritual tablets."
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
                tblView.rowHeight = labelSize.height + 10.0
                
            } else if isComingAbout == AboutUs.historyOrigin {
                labelStr.text = isComingAbout
                contactDetailsStr = " Pyramid Spiritual Societies Movement (PSSM) was founded by enlightened master “Brahmarshi Patriji” in the year 1990 with the objective, spiritual and harmonious living and bringing its benefits within the easy reach of all humanity, without any barriers of class, religion or region. Starting from its humble beginning with “The Kurnool Spiritual Society” in 1990, the Pyramid Meditation Movement is now spread by 2,000 independent and autonomous Pyramid Spiritual Societies involving millions of active members and volunteers across India, New Zealand, Australia, USA, UK, Singapore, Malaysia, UAE, Vietnam, Mauritius and Sri Lanka.\n\nThe Pyramid Spiritual Societies Movement is non-religious, non-cult, non-profit voluntary organization with the mission to spread “Anapanasati Meditation, Vegetarianism and Pyramid Power” to everyone.\n\n“Dr. Gopala Krishna” is a medical doctor who started his journey of spiritual science in search of happiness and the truth, under the guidance of “Brahmarshi Patriji” and specially trained by grand master “Paul Vijay Kumar”. In this journey he got enlightened and realized that “Spiritual intellect is the root – physical health is the fruit”. He started sharing the same with his patients who approached him for medical treatment. As a part of this, he established spiritual health care centers and maintained them for ten years in different parts of India, also offered esteemed spiritual services as an ancillary to qualified treatment with the help of senior masters who are trained by him.\n\nNow we want to expand our services all over the world through offering franchise for establishing such centers. For this we established and registered a Non-Profit organization which is structured from center in charge to the CEO."
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
                tblView.rowHeight = labelSize.height + 100.0
            } else if isComingAbout == AboutUs.principle {
                labelStr.text = isComingAbout
                var label = UILabel()
                label.font = UIFont(name: "", size: 18)
                label.text = "Key Quotes"
                contactDetailsStr = "As per the World Health Organization definition, the main aim of these spiritual health care centers is to give good health by providing basic solution with self-energy for physical, mental, social and spiritual disparities. The main objective is to give extensive training in meditation & spiritual science apart from traditional medical system.\n\nKey Quotes:\n\n1.Lord Sri Krishna in Bhagavad-Gita – Gnanamani Dagdha Karmaanam!\n\n2.Jesus Christ in Holy Bible – A good word brings relief\n\n3.Brahmarshi Patriji – “Knowledge due to Meditation – freedom due to knowledge”.\n\n4.Patriji – “Our sins are our weaknesses” – “non-vegetarian is sinful food”\n\n5.Patriji – “Leave Violence – Follow non-violence”.\n\n6.Patriji – Spiritual intellect is the root – physical health is the fruit.\n\n7.Lack of Spiritual Knowledge is the root cause for all sufferings – By Dr Gk.\n\nReason For illness:\n\nDue to irregular, unwanted and un-scientific food habits, thinking methods and mutual relationships.\n\nMode of training in spiritual health care centers:\n\nIn this method, the persons with an ill-health are all considered as ECW (Energy-Consciousness-Wisdom) units, who are momentarily stagnated in unscientific belief systems. After an initial audio-visual demo, they will be trained to meditate on ‘Natural breath observation’. There after importance of vegetarian food, significance of pyramid power and spiritual science will be explained. They are allowed to practice it for a minimum of 40 days at their home or center and during which there will be a follow-up. Periodically, they can avail the opportunity to participate in group meditation and spiritual sharing with masters. They have to follow the spiritual advice given in the form of spiritual tablets during counseling which are available at libraries and spiritual health care centers.\n\nAfter getting symptomatic relief by basic training, they are allowed to participate in meditation classes to share their experiences. In due course of time, the patient should be examined by certified doctors (patient’s family doctors or by the organization) and the medication will be regularized accordingly. In some cases, as part of training they need to learn fine arts like dance and music\n\nSimilar to other medical practices of prescribing tablets, 350 SPIRITUAL TABLETS are prepared in Spiritual health system. They are the heart of Spiritual Health Care Centers. These tablets (concepts) are easily understood and can be remembered by the patients for implementing in their daily life. They are available in the form of pamphlets, pocket books and audio/visuals. Prescribing these tablets as per the experience and requirement of patient is the main practice in Life health counseling.\n\nIn many cases, it has been proved that any kind of health problem is due to ignorance and lack of spiritual knowledge. Through health counseling, it will be cured at the root-level and the patient will be made self-sufficient to attain complete health.\n\nProcedure/Initiation:\n\na) Basics of Meditation and 12 tablets (for 40 days)\n\nb) Spiritual health counselling: After Symptomatic Relief with Basic Meditation for 40 Days, efficient analytical Spiritual health Counselling based on their Meditational experiences, dreams and coincidences is given.\n\nc) Home Visit: Home visit facility is available for elderly and bed ridden patients.\n\nd) Childhood problems: For all kinds of childhood problems (MR. Autism, Behavioral problems and mental illness), spiritual training will be initially given to the parents. After getting some relief, training will be imparted to the diseased\n\ne) For Serious cases (Terminal illness): 5 fold approach (Regular Meditation, In-charge of the material, GPM, Diet Energetic Environment and Relationship care taker(DEER), and a qualified DOCTOR.\n\nFollow Up:\n\n*Frequent Visits by efficient GPMs to centers\n\n*Online Spiritual Counseling\n\n*Spiritual Prescriptions through mail\n\n*Phone follow up\n\n*Postal follow up\n\n*Dispensing of spiritual material\n\nSpiritual Doctor:\n\n*The existing medical systems till date are all focusing at the body level\n\n*But the Meditation health system is a method where True Spiritual Science (Soul Science) will be taught to the person who is suffering from different ailments\n\n*Once the blockage at Knowledge level or intellectual plane is combated, then problem at physical level will be cleared automatically.\n\n*The person who is trained in existing qualified medical system (medical & paramedical) is more eligible to learn spiritual tablets…the combination is more helpful in delivering efficient spiritual health counselling.\n\n12 Tablets for Complete Health:\n\n1.Individual Meditation: ‘Doing Meditation by observation of natural breath’ can be done every day at any place or at any time.\n\n2.Group Meditation: Meditation can be done in 40 days classes either at Meditation Centers or at their home along with all family members\n\n3.Pyramid meditation: Pyramid meditation will provide 3-times more cosmic energy. Therefore, one may use pyramid at the house or may go to a pyramid spiritual Centre for doing Meditation\n\n4.Full-moon Meditation: If Meditation is done through-out the night of a full-moon, the patient will get three times more energy and also will come to know about the reasons for his ill-health. He can identify whether the problem is with past life karma or due to present defective life pattern.\n\n5.Vegetarianism: Eating non-vegetarian food (including eggs) should be avoided. The real food for human body is fruits and breath\n\n6.Optimal diet & silence: The daily work done by the organs is like food for the soul. One should take their food limitedly as per the requirement. As per the Masters advice and one’s own meditational experiences, he/she has to follow “complete silence.”\n\n7.Reading of Spiritual Books: Read spiritual books daily to improve knowledge\n\n8.Sharing of Experiences: One should share their Meditational experiences with meditators to develop their spiritual knowledge.\n\n9.Health Science Classes: One should participate in meditation classes conducted by senior masters or they should listen to the spiritual lectures transmitted in TV or other audio visual media.\n\n10.Spiritual Health Counseling: Twice in a month one should interact with a senior master and discuss their personal experiences for any clarifications and plan their future practices.\n\n11.Living with the nature: Once in a while, one should spend time in nature and take energy and joy.\n\n12.Spiritual Science service: After attaining self knowledge and realizing the power of Vegetarianism and pyramid one should share their experiences with several other people and try to induce interest in them.\n\nThe above twelve tablets will be made available at all spiritual health centers along with below mentioned facilities.\n\nCenter facilities:\n\n1.Reception\n\n2.Pyramid Meditation Room\n\n3.Spiritual books library & A/V Room\n\n4.Special powerful pyramid Chamber\n\n5.Life Health Counselling Chamber\n\n6.Health science class-room\n\n7.Spiritual Books and CDs for sale\n\n8.Music & Dance learning center"
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
                tblView.rowHeight = labelSize.height + 100.0
            } else if isComingAbout == AboutUs.pyramidDoctors {
                labelStr.text = isComingAbout
                contactDetailsStr =
                "Dr. Gopala Krishna (GK)\nDr. T.V Rao\nDr. Vasantha\nDr. Sadhashivudu\nDr. Padmaja\nDr. Gopi Krishna\nDr. Mahesh Ashlkar\nDr. Devi\nDr. Sudha Madhavi\nDr. Bal Ram Pratap Kumar\nDr. Satya Narayana\nDr. Hema Nalini"
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
                tblView.rowHeight = labelSize.height + 10.0
            } else if isComingAbout == AboutUs.outlets {
                labelStr.text = isComingAbout
                contactDetailsStr = "Meditation Health Service Centre\n\nPyramid Meditation Health Centers (Rural)\n\nPyramid Real Relief Centers (Urban)\n\nPyramid Spiritual Health Care Centre (Admin Centre)\n\nHolistic Health Care Centers\n\nWebsite (Online)\n\nMeditation Health Publication\nAdvertisement General & Cultural adds -2 days patients training WS\n\n3 days Employee Training WS – Spiritual Health Magazines\n\nKiosks\nCultural Events\n\nWorkshops\n\nHome Visits"
                checkBoxCell.detailedStr.text = self.contactDetailsStr
                let labelSize = checkBoxCell.detailedStr.getSize(constrainedWidth:checkBoxCell.detailedStr.frame.size.width)
                tblView.rowHeight = labelSize.height + 10.0
            } else if isComingAbout == AboutUs.founder {
                detailedStr.isHidden = true
                founderLblStr.isHidden = false
                founderImage.isHidden = false
                labelStr.text = isComingAbout
                contactDetailsStr = "Dr. Gopala Krishna is a Medical Doctor from India who has 10 years of clinical experience and worked as DMO in Neuro Surgery, Pediatric and General Medicine department. He also has private practice in rural areas and worked as Medical Officer for Jarawa tribes in Andaman Islands.\n\n“Dr. Gopala Krishna” is also a spiritual scientist. He is an enlightened yogi, mystic and visionary who have dedicated himself to the elevation of the physical, mental, and spiritual well-being of people. He has shown a path for the people to attain natural joy and to live life with experience from their own inner nature through Pyramid power and Spiritual Tablets. His scientific approach towards spirituality and work towards the uplift of the humanity have received accolades in southern India, Malaysia, Singapore, Andaman, US & UK. Spiritual Tablets are the most profound, with greater intensity from his deep understanding and wisdom which can change the very core of the being.\n\nBelonging to no particular religion or tradition, “Spiritual Tablets” incorporates the modern person to the spiritual sciences. Spiritual Tablets, are the out pouring of his blissfulness, finds expression in the form of ceaseless offering to all beings. His life and Spiritual Tablets are invitation to connect with the divinity within us through individual transformation and welcomes the silent revolution of self realization."
              //  self.founderLblStr.text = self.contactDetailsStr
               // let labelSize = self.founderLblStr.getSize(constrainedWidth:self.founderLblStr.frame.size.width)
               // self.scrolheightConstraint.constant = labelSize.height + 10.0
            }
            return checkBoxCell
        }
        return UITableViewCell()
    }
}
