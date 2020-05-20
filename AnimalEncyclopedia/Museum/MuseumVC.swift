//
//  MuseumVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import Segmentio

protocol MuseumVCDelegate {
    func showDetailed(_ vc: UIViewController)
}

class MuseumVC: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentView: Segmentio!
    var isClickedSegmented = false
    var isScroll = false
    var nowPage = 0
    @IBOutlet weak var fishView: FishView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fishView.delegate = self
        
        segmentView.setup(content: [
            SegmentioItem(title: "魚", image: UIImage(named: "fish")),
            SegmentioItem(title: "昆蟲", image: UIImage(named: "butterfly")),
            SegmentioItem(title: "化石", image: UIImage(named: "fossil")),
            SegmentioItem(title: "藝術品", image: UIImage(named: "painting"))
        ], style: .imageOverLabel,
           options: SegmentioOptions(backgroundColor: .white, segmentPosition: .fixed(maxVisibleItems: 3), scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: .systemBlue), horizontalSeparatorOptions:SegmentioHorizontalSeparatorOptions(type: .top, height: 1, color: UIColor(red: 245, green: 245, blue: 245, alpha: 1)), verticalSeparatorOptions:SegmentioVerticalSeparatorOptions(ratio: 1, color: UIColor(red: 245, green: 245, blue: 245, alpha: 1)), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black), selectedState: SegmentioState(backgroundColor: .clear, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black), highlightedState: SegmentioState(backgroundColor: .systemGray, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black)), animationDuration: 0.3))
        
        segmentView.selectedSegmentioIndex = 0
        
        segmentView.valueDidChange = { [weak self] _, segmentIndex in
            
            if self?.isScroll ?? false {
                return
            }
            
            self?.scrollView.setContentOffset(CGPoint(x: (self?.view.frame.width ?? 0)*CGFloat(segmentIndex), y: 0), animated: true)
            self?.isClickedSegmented = true
        }
        
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
                
                segmentView.selectedSegmentioIndex = page
                nowPage = page
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageWidth: CGFloat = view.frame.width
        let page: Int = Int(scrollView.contentOffset.x / pageWidth)
        
        if segmentView.selectedSegmentioIndex != page {
            segmentView.selectedSegmentioIndex = page
        }
        isClickedSegmented = false
        isScroll = false
    }
}
