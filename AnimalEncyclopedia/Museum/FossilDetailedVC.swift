//
//  FossilDetailedVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/20.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FossilDetailedVC: UIViewController {

    @IBOutlet weak var topBaseView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var enName: UILabel!
    @IBOutlet weak var jpName: UILabel!
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var introduction: UILabel!
    var fossilData: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        topBaseView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topBaseView.layer.shadowOpacity = 0.7
        topBaseView.layer.shadowRadius = 5
        topBaseView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        name.text = fossilData[0]
        enName.text = fossilData[1]
        jpName.text = fossilData[2]
        money.text = fossilData[3]
        introduction.text = fossilData[4]
        imageView.sd_setImage(with: URL(string: "\(fossilData[5])"), completed: nil)
    }
}
