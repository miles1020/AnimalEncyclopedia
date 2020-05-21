//
//  MuseumVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import TwicketSegmentedControl

protocol MuseumVCDelegate {
    func showDetailed(_ vc: UIViewController)
}

class MuseumVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    var isClickedSegmented = false
    var isScroll = false
    var nowPage = 0
    @IBOutlet weak var segmentView: TwicketSegmentedControl!
    @IBOutlet weak var fishView: FishView!
    @IBOutlet weak var insectView: InsectView!
    @IBOutlet weak var fossilView: FossilView!
    @IBOutlet weak var artworkView: ArtworkView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentView.setSegmentItems(["魚", "昆蟲", "化石", "藝術品"])
        segmentView.backgroundColor = .clear
        segmentView.delegate = self
        
        fishView.delegate = self
        insectView.delegate = self
        fossilView.delegate = self
        artworkView.delegate = self
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "搜尋..."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.delegate = self
        searchController.searchBar.returnKeyType = .done
        navigationItem.searchController = searchController
    }
}

extension MuseumVC: MuseumVCDelegate {
    func showDetailed(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MuseumVC: UISearchBarDelegate {
    
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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
//        if isFilter {
//            animalAry = resultList
//        } else {
//            animalAry = animalModel
//        }
//        collectionView.reloadData()
//        isSearch = false
    }
}

extension MuseumVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if !isClickedSegmented {
            
            isScroll = true
            
            let pageWidth: CGFloat = scrollView.frame.width
            let tmpPageInt: Int = Int(scrollView.contentOffset.x / pageWidth)
            let tmpPageFloat: CGFloat = scrollView.contentOffset.x / pageWidth
            let page: Int = tmpPageFloat - CGFloat(tmpPageInt) >= 0.5 ? tmpPageInt + 1 : tmpPageInt
            
            if nowPage != page {
                
                segmentView.move(to: page) 
                nowPage = page
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth: CGFloat = view.frame.width
        let page: Int = Int(scrollView.contentOffset.x / pageWidth)
        
        if segmentView.selectedSegmentIndex != page {
            segmentView.move(to: page)
        }
        isClickedSegmented = false
        isScroll = false
    }
}

extension MuseumVC: TwicketSegmentedControlDelegate {
    
    func didSelect(_ segmentIndex: Int) {
        
        if isScroll {
            return
        }

        scrollView.setContentOffset(CGPoint(x: (view.frame.width)*CGFloat(segmentIndex), y: 0), animated: true)
        isClickedSegmented = true
    }
}
