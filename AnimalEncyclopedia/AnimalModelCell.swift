//
//  AnimalModelCell.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/7.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class AnimalModelCell: UICollectionViewCell {
    
    @IBOutlet weak var animalImageView: UIImageView!
    @IBOutlet weak var animalName: UILabel!
    @IBOutlet weak var animalGender: UILabel!
    @IBOutlet weak var animalCharacter: UILabel!
    @IBOutlet weak var animalRace: UILabel!
    @IBOutlet weak var animalBirthday: UILabel!
    @IBOutlet weak var animalMantra: UILabel!
    @IBOutlet weak var animalAims: UILabel!
    @IBOutlet weak var animalMotto: UILabel!
    

    override func layoutSubviews() {
        
        animalImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        animalImageView.layer.shadowOpacity = 0.7
        animalImageView.layer.shadowRadius = 5
        animalImageView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        layer.shadowOffset = CGSize(width: 5, height: 5)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
        layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Code below is needed to make the self-sizing cell work when building for iOS 12 from Xcode 10.0:
        let leftConstraint = contentView.leftAnchor.constraint(equalTo: leftAnchor)
        let rightConstraint = contentView.rightAnchor.constraint(equalTo: rightAnchor)
        let topConstraint = contentView.topAnchor.constraint(equalTo: topAnchor)
        let bottomConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
    }
}
