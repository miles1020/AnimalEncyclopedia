//
//  DIYVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/18.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class DIYVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    var diyAry: Array<Array<String>> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "DIY"
        
        diyAry = DIYModel
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-20, height: (UIScreen.main.bounds.width/3-20)*1.5)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜尋..."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .done
        navigationItem.searchController = searchController
    }
}

extension DIYVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
        if searchText == "" {
            diyAry = DIYModel
            collectionView.reloadData()
            return
        }

        var diyList: Array<Array<String>> = []

        for item in diyAry {

            if item[0].contains(searchText) {

                diyList.append(item)
            }
        }

        diyAry = diyList
        collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        diyAry = DIYModel
        collectionView.reloadData()
    }
}

extension DIYVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return diyAry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DIYCell", for: indexPath) as! DIYCell
        
        cell.imageView.sd_setImage(with: URL(string: diyAry[indexPath.row][5]), completed: nil)
        cell.name.text = diyAry[indexPath.row][0]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let diyDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DIYDetailedVC") as! DIYDetailedVC
        diyDetailedVC.diyData = diyAry[indexPath.row]
        navigationController?.pushViewController(diyDetailedVC, animated: true)
    }
}
