//
//  FastScrollWheel.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/3/21.
//

import Foundation
import UIKit

class FastScrollBar: UIView {
    
    // ScrollBar 的圖片
    var imageView: UIImageView?
    
    var baseView: UIView!
    var scrollView: UIScrollView!
    
    var safeAreaInset: UIEdgeInsets = UIApplication.shared.windows.first!.safeAreaInsets
    
    var topPosition: CGFloat!
    var bottomPosition: CGFloat!
    
    init(baseView: UIView, scrollView: UIScrollView, frame: CGRect, top: CGFloat, bottom: CGFloat) {
        super.init(frame: frame)
        self.baseView = baseView
        self.scrollView = scrollView
        self.topPosition = top
        self.bottomPosition = bottom
        
        setInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setInit() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(fastScrollWheelPanFunction(_:)))
        self.addGestureRecognizer(pan)
        
        self.scrollView.delegate = self
        self.scrollView.showsVerticalScrollIndicator = false
        
        self.backgroundColor = .lightGray
    }
    
    func setImage(image: UIImage, contentMode: UIView.ContentMode = .scaleAspectFill) {
        self.imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        imageView?.contentMode = contentMode
        imageView?.image = image
        self.addSubview(imageView!)
    }
    
    func scrollScrollViewToPercent(_ percent: CGFloat) {
        scrollView.setContentOffset(CGPoint(x: 0,
                                            y: (scrollView.contentSize.height - scrollView.frame.height + safeAreaInset.bottom) * percent),
                                    animated: false)
    }
    
    func moveScrollBarToPercent(_ percent: CGFloat) {
        self.frame = CGRect(x: self.frame.minX,
                            y: (bottomPosition - topPosition - self.frame.height) * percent + topPosition,
                            width: self.frame.width,
                            height: self.frame.height)
    }
    
    @objc func fastScrollWheelPanFunction(_ recognizer:UIPanGestureRecognizer) {
        guard let scrollBar = recognizer.view else { print("recognizer.view is nil"); return }
        
        let panY = recognizer.location(in: baseView).y
        var percent = (scrollBar.frame.minY - topPosition) / (bottomPosition - topPosition - scrollBar.frame.height)
        
        func moveToTop() {
            UIView.animate(withDuration: 0.1) { [self] in
                scrollBar.frame = CGRect(x: scrollBar.frame.minX,
                                         y: topPosition,
                                         width: scrollBar.frame.width,
                                         height: scrollBar.frame.height)
                percent = 0
                scrollScrollViewToPercent(percent)
            }
        }
        
        func moveToBottom() {
            UIView.animate(withDuration: 0.1) { [self] in
                scrollBar.frame = CGRect(x: scrollBar.frame.minX,
                                         y: bottomPosition - scrollBar.frame.height,
                                         width: scrollBar.frame.width,
                                         height: scrollBar.frame.height)
                percent = 1
                scrollScrollViewToPercent(percent)
            }
        }
        
        guard panY - (scrollBar.frame.height / 2) >= topPosition else { moveToTop(); return }
        guard panY + (scrollBar.frame.height / 2) <= bottomPosition else { moveToBottom(); return }
        
        scrollBar.frame = CGRect(x: scrollBar.frame.minX,
                                 y: panY - (scrollBar.frame.height / 2),
                                 width: scrollBar.frame.width,
                                 height: scrollBar.frame.height)
        
        percent = (scrollBar.frame.minY - topPosition) / (bottomPosition - topPosition - scrollBar.frame.height)
        scrollScrollViewToPercent(percent)
    }
    
}

extension FastScrollBar: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let percent = scrollView.contentOffset.y / (scrollView.contentSize.height - scrollView.frame.height + safeAreaInset.bottom)
        moveScrollBarToPercent(percent)
    }
    
}
