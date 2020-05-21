//
//  FossilView.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class FossilView: UIView {

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

extension FossilView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return fossilModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FossilViewCell", for: indexPath) as! FossilViewCell
        
        cell.name.text = fossilModel[indexPath.row][0]
        cell.imageView.sd_setImage(with: URL(string: fossilModel[indexPath.row][5]), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let fossilDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FossilDetailedVC") as! FossilDetailedVC
        fossilDetailedVC.fossilData = fossilModel[indexPath.row]
        delegate?.showDetailed(fossilDetailedVC)
    }
}
