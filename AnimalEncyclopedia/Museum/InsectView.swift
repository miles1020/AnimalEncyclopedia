//
//  InsectView.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class InsectView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: MuseumVCDelegate?
    
    override func awakeFromNib() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-20, height: (UIScreen.main.bounds.width/3-20)*1.5)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
}

extension InsectView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return insectModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InsectViewCell", for: indexPath) as! InsectViewCell
        
        cell.name.text = insectModel[indexPath.row][0]
        cell.imageView.sd_setImage(with: URL(string: insectModel[indexPath.row][6]), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let insectDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InsectDetailedVC") as! InsectDetailedVC
        insectDetailedVC.insectData = insectModel[indexPath.row]
        delegate?.showDetailed(insectDetailedVC)
    }
}
