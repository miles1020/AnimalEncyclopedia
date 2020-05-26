//
//  FishView.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FishView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: MuseumVCDelegate?
    var fishAry: Array<Array<String>> = []
    
    override func awakeFromNib() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-20, height: (UIScreen.main.bounds.width/3-20)*1.5)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        fishAry = fishModel
    }
}

extension FishView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fishAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FishViewCell", for: indexPath) as! FishViewCell
        
        cell.name.text = fishAry[indexPath.row][0]
        
        cell.imageView.sd_setImage(with: URL(string: fishAry[indexPath.row][7]), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let fishDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FishDetailedVC") as! FishDetailedVC
        fishDetailedVC.fishData = fishAry[indexPath.row]
        delegate?.showDetailed(fishDetailedVC)
    }
}
