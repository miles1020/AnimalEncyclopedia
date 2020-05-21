//
//  InsectDetailedVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/20.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class InsectDetailedVC: UIViewController {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var infestedPlace: UILabel!
    @IBOutlet weak var northMonth: UILabel!
    @IBOutlet weak var southMonth: UILabel!
    @IBOutlet weak var infestedTime: UILabel!
    @IBOutlet weak var money: UILabel!
    var insectData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topBaseView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topBaseView.layer.shadowOpacity = 0.7
        topBaseView.layer.shadowRadius = 5
        topBaseView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        name.text = insectData[0]
        infestedPlace.text = insectData[1]
        northMonth.text = insectData[2]
        southMonth.text = insectData[3]
        infestedTime.text = insectData[4]
        money.text = insectData[5]
        imageView.sd_setImage(with: URL(string: "\(insectData[6])"), completed: nil)
    }
}
