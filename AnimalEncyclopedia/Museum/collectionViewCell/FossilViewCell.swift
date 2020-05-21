//
//  FossilViewCell.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FossilViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func layoutSubviews() {
        
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 3
        layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
    } 
}
