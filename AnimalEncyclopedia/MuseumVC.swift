//
//  MuseumVC.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/19.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import Segmentio

class MuseumVC: UIViewController {

    @IBOutlet weak var segmentView: Segmentio!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentView.setup(content: [
            SegmentioItem(title: "魚", image: UIImage(named: "fish")),
            SegmentioItem(title: "昆蟲", image: UIImage(named: "butterfly")),
            SegmentioItem(title: "化石", image: UIImage(named: "fossil")),
            SegmentioItem(title: "藝術品", image: UIImage(named: "painting"))
        ], style: .imageOverLabel,
           options: SegmentioOptions(backgroundColor: .white, segmentPosition: .fixed(maxVisibleItems: 3), scrollEnabled: true, indicatorOptions: SegmentioIndicatorOptions(type: .bottom, ratio: 1, height: 5, color: .systemBlue), horizontalSeparatorOptions:SegmentioHorizontalSeparatorOptions(type: .top, height: 1, color: UIColor(red: 245, green: 245, blue: 245, alpha: 1)), verticalSeparatorOptions:SegmentioVerticalSeparatorOptions(ratio: 1, color: UIColor(red: 245, green: 245, blue: 245, alpha: 1)), imageContentMode: .center, labelTextAlignment: .center, labelTextNumberOfLines: 1, segmentStates: SegmentioStates(defaultState: SegmentioState(backgroundColor: .clear, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black), selectedState: SegmentioState(backgroundColor: .clear, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black), highlightedState: SegmentioState(backgroundColor: .yellow, titleFont: UIFont(name: "Avenir-Book", size: 12)!, titleTextColor: .black)), animationDuration: 0.3))
        
        segmentView.selectedSegmentioIndex = 0
        
        segmentView.valueDidChange = { [weak self] _, segmentIndex in
            
            
        }
    }
}
