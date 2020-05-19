//
//  DIYDetailedVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/18.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class DIYDetailedVC: UIViewController {

    var diyData: Array<String> = []
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var material: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var getFunc: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var topBaseView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBaseView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topBaseView.layer.shadowOpacity = 0.7
        topBaseView.layer.shadowRadius = 5
        topBaseView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        title = diyData[0]
        name.text = diyData[0]
        type.text = diyData[1]
        getFunc.text = diyData[2]
        size.text = diyData[3]
        material.text = diyData[4]
        imageView.sd_setImage(with: URL(string: diyData[5]), completed: nil)
    }
}
