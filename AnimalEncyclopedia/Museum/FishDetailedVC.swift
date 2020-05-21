//
//  FishDetailedVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FishDetailedVC: UIViewController {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var infestedPlace: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var northMonth: UILabel!
    @IBOutlet weak var southMonth: UILabel!
    @IBOutlet weak var infestedTime: UILabel!
    @IBOutlet weak var money: UILabel!
    var fishData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topBaseView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topBaseView.layer.shadowOpacity = 0.7
        topBaseView.layer.shadowRadius = 5
        topBaseView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        name.text = fishData[0]
        infestedPlace.text = fishData[1]
        size.text = fishData[2]
        northMonth.text = fishData[3]
        southMonth.text = fishData[4]
        infestedTime.text = fishData[5]
        money.text = fishData[6]
        imageView.sd_setImage(with: URL(string: "\(fishData[7])"), completed: nil)
    }
}
