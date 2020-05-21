//
//  PictureView.swift
//  JPWApp
//
//  Created by HellöM on 2020/3/2.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

public class PictureView: UIView {
    
    var baseView: UIView!
    var image: UIImage!
    var scrollView: UIScrollView!
    var imageView: UIImageView!
    var isZoom = false
    var oldFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
    var pan: UIPanGestureRecognizer!
    
    public init(_ image: UIImage) {
        super.init(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: fullScreenSize.height))
        alpha = 0
        
        backgroundColor = .clear
        
        self.image = image
        
        initUI()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {
        
        baseView = UIView(frame: frame)
        baseView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
        addSubview(baseView)
        
        scrollView = UIScrollView(frame: frame)
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: frame.width, height: frame.height)
        addSubview(scrollView)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.width))
        imageView.center = center
        imageView.image = self.image
        imageView.isUserInteractionEnabled = true
        imageView.isMultipleTouchEnabled = true
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        UIApplication.shared.keyWindow!.addSubview(self)
        
        oldFrame = imageView.frame
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(lognPressHandler(_:)))
        longPress.minimumPressDuration = 0.8
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        tap.numberOfTapsRequired = 2
        tap.delegate = self
        
        pan = UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:)))
        pan.delegate = self
        
        addGestureRecognizer(longPress)
        imageView.addGestureRecognizer(tap)
        imageView.addGestureRecognizer(pan)
    }
    
    @objc
    func lognPressHandler(_ tap: UILongPressGestureRecognizer) {
        
        if tap.state == .began {
            
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let save = UIAlertAction(title: "儲存圖片", style: .default) { (action) in
                
                UIImageWriteToSavedPhotosAlbum(self.image, nil, nil, nil)
            }
            
            alertController.addAction(cancel)
            alertController.addAction(save)
            
            UIApplication.shared.keyWindow!.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc
    func tapHandler(_ tap: UITapGestureRecognizer) {
        
        let scroll = tap.view?.superview as? UIScrollView
        
        if !isZoom {
            
            let newRect = zoomRectByScale(3, center: tap.location(in: tap.view))
            scroll?.zoom(to: newRect, animated: true)
            
            isZoom = true
        } else {
            
            scroll?.setZoomScale(1, animated: true)
            self.isZoom = false
        }
    }
    
    func zoomRectByScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        
        var zoomRect = CGRect(x: 0, y: 0, width: 0, height: 0)
        
        zoomRect.size.width = frame.size.width/scale
        zoomRect.size.height = frame.size.height/scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width/2)
        zoomRect.origin.y = center.y - (zoomRect.size.height/2)
        
        return zoomRect
    }
    
    @objc
    func panHandler(_ tap: UIPanGestureRecognizer) {
        
        let view = tap.view!
        
        switch tap.state {
        case .changed:
            
            let translation = tap.translation(in: view.superview)
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            tap.setTranslation(CGPoint.zero, in: view.superview)
            
            let al = 1 - (abs(oldFrame.origin.y - view.frame.origin.y) / 400) < 0.5 ? 0.5 : 1 - (abs(oldFrame.origin.y - view.frame.origin.y) / 400)
            
            self.baseView.alpha = al
        case .ended:
            
            if view.frame.origin.y > frame.size.height/2 || view.frame.maxY < frame.size.height/2 {
                
                UIView.animate(withDuration: 0.3, animations: {
                    
                    self.alpha = 0
                }) { (Bool) in
                    self.removeFromSuperview()
                }
                
            } else {
                UIView.animate(withDuration: 0.3) {
                    
                    view.center = self.center;
                    self.baseView.alpha = 1;
                }
            }
        default:
            break
        }
    }
}

extension PictureView: UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        
        return imageView
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        
        isZoom = true
        imageView.removeGestureRecognizer(pan)
        
        var frame = imageView.frame
        
        frame.origin.y = (scrollView.frame.size.height - imageView.frame.size.height) > 0 ? (scrollView.frame.size.height - imageView.frame.size.height) * 0.5 : 0
        frame.origin.x = (scrollView.frame.size.width - imageView.frame.size.width) > 0 ? (scrollView.frame.size.width - imageView.frame.size.width) * 0.5 : 0
        
        imageView.frame = frame
        scrollView.contentSize = CGSize(width: self.imageView.frame.size.width, height: self.imageView.frame.size.height)
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        if scale == 1 {
            
            isZoom = false
            imageView.addGestureRecognizer(pan)
        } else {
            
            isZoom = true
        }
    }
}
