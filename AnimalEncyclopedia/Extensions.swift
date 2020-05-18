//
//  Extensions.swift
//  AnimalEncyclopedia
//
//  Created by HellöM on 2020/5/6.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    @IBInspectable var borderColor: UIColor? {
        
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get {
            return layer.cornerRadius
        }
        
        set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
}
