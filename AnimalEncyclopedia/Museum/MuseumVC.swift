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
        
        var resultList: Array<Array<String>> = []
        
        if searchText == "" {
            
            switch nowPage {
            case 0:
                fishView.fishAry = fishModel
                fishView.collectionView.reloadData()
            case 1:
                insectView.insectAry = insectModel
                insectView.collectionView.reloadData()
            case 2:
                fossilView.fossilAry = fossilModel
                fossilView.collectionView.reloadData()
            case 3:
                artworkView.artworkAry = artworkModel
                artworkView.collectionView.reloadData()
            default:
                resultList = []
            }
            
            return
        } 

        var data: Array<Array<String>> = []
        switch nowPage {
        case 0:
            data = fishModel
        case 1:
            data = insectModel
        case 2:
            data = fossilModel
        case 3:
            data = artworkModel
        default:
            resultList = []
        }
        
        for item in data {

            if item[0].contains(searchText) {

                resultList.append(item)
            }
        }
        
        switch nowPage {
        case 0:
            fishView.fishAry = resultList
            fishView.collectionView.reloadData()
        case 1:
            insectView.insectAry = resultList
            insectView.collectionView.reloadData()
        case 2:
            fossilView.fossilAry = resultList
            fossilView.collectionView.reloadData()
        case 3:
            artworkView.artworkAry = resultList
            artworkView.collectionView.reloadData()
        default:
            resultList = []
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        switch nowPage {
        case 0:
            fishView.fishAry = fishModel
            fishView.collectionView.reloadData()
        case 1:
            insectView.insectAry = insectModel
            insectView.collectionView.reloadData()
        case 2:
            fossilView.fossilAry = fossilModel
            fossilView.collectionView.reloadData()
        case 3:
            artworkView.artworkAry = artworkModel
            artworkView.collectionView.reloadData()
        default:
            break
        }
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
        
        nowPage = segmentIndex
        scrollView.setContentOffset(CGPoint(x: (view.frame.width)*CGFloat(segmentIndex), y: 0), animated: true)
        isClickedSegmented = true
    }
}
