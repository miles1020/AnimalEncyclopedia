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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "DIY"
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 30, right: 15)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-20, height: (UIScreen.main.bounds.width/3-20)*1.5)
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜尋..."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
}

extension DIYVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            
            //        if searchText == "" {
            //            if isFilter {
            //                animalAry = resultList
            //            } else {
            //                animalAry = animalModel
            //            }
            //            collectionView.reloadData()
            //            isSearch = false
            //            return
            //        }
            //
            //        isSearch = true
            //
            //        var animalList: Array<Array<String>> = []
            //
            //        for item in animalAry {
            //
            //            if item[0].contains(searchText) {
            //
            //                animalList.append(item)
            //            }
            //        }
            //
            //        animalAry = animalList
            //        collectionView.reloadData()
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            
            view.endEditing(true)
        }
    }
}

extension DIYVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return diyTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DIYCell", for: indexPath) as! DIYCell
        
        cell.imageView.sd_setImage(with: URL(string: diyImage[indexPath.row]), completed: nil)
        cell.name.text = diyTitle[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let diyDetailedVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DIYDetailedVC") as! DIYDetailedVC
        
        navigationController?.pushViewController(diyDetailedVC, animated: true)
        
        print(indexPath.row)
    }
}
