//
//  ImageViewVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 02/07/23.
//

import UIKit

class ImageViewVC: UIViewController {
    
    var imageUrl = ""
    
    @IBOutlet weak var galleryImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        if let url = URL(string: imageUrl) {
            DispatchQueue.main.async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self.galleryImage.image = UIImage(data: data)
                }
            }
        }
    }
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }


}
