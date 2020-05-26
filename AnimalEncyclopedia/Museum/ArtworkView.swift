//
//  ArtworkView.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class ArtworkView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    var delegate: MuseumVCDelegate?
    var artworkAry: Array<Array<String>> = []
    
    override func awakeFromNib() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-20, height: (UIScreen.main.bounds.width/3-20)*1.5)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
}

extension ArtworkView: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return artworkAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtworkViewCell", for: indexPath) as! ArtworkViewCell
        
        cell.name.text = artworkAry[indexPath.row][0]
        cell.imageView.sd_setImage(with: URL(string: artworkAry[indexPath.row][4]), completed: nil)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let artworkDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtworkDetailedVC") as! ArtworkDetailedVC
        artworkDetailedVC.artworkData = artworkAry[indexPath.row]
        delegate?.showDetailed(artworkDetailedVC)
    }
}
