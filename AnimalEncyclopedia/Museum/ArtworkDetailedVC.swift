//
//  ArtworkDetailedVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/20.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class ArtworkDetailedVC: UIViewController {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var authenticity: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var money: UILabel!
    var artworkData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topBaseView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topBaseView.layer.shadowOpacity = 0.7
        topBaseView.layer.shadowRadius = 5
        topBaseView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        name.text = artworkData[0]
        authenticity.text = artworkData[1]
        size.text = artworkData[2]
        money.text = artworkData[3]
        imageView.sd_setImage(with: URL(string: "\(artworkData[4])"), completed: nil)
    }
    
    @IBAction func zoomClick(_ sender: UIButton) {
    
        let _ = PictureView(imageView.image!)
    }
}
