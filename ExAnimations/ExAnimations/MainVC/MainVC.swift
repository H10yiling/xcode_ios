//
//  MainVC.swift
//  ExAnimations
//
//  Created by 侯懿玲 on 2021/12/2.
//

import UIKit

class MainVC: UIViewController, UIScrollViewDelegate {
    
    var myScrollView: UIScrollView!
    var pageControl: UIPageControl!
    var fullSize :CGSize!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false) // 隱藏 navigationBar
        
        fullSize = UIScreen.main.bounds.size // 取得螢幕的尺寸
        
        setScrollView()
        
        pages()
    }
    func setScrollView(){
        // 建立 UIScrollView
        myScrollView = UIScrollView()
        // 設置委任對象
        myScrollView.delegate = self
        
        // 設置尺寸(可見視圖範圍
        myScrollView.frame = CGRect(x: 0, y: 20, width: fullSize.width, height: fullSize.height)
        
        // 實際視圖範圍
        myScrollView.contentSize = CGSize(width: fullSize.width * 5, height: fullSize.height)
        
        // 以一頁為單位滑動
        myScrollView.isPagingEnabled = true
        
        // 是否顯示滑動條(預設true會顯示
//        myScrollView.showsHorizontalScrollIndicator = false
//        myScrollView.showsVerticalScrollIndicator = false
        // 滑動超過範圍時是否使用彈回效果(預設true會回彈
//        myScrollView.bounces = false
        
        // 加入到畫面中
        self.view.addSubview(myScrollView)
        
        // 建立 UIPageControl 設置位置及尺寸
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: fullSize.width * 0.85, height: 50))
        pageControl.center = CGPoint(x: fullSize.width * 0.5, y: fullSize.height * 0.85)
        
        // 有幾頁 就是有幾個點
        pageControl.numberOfPages = 5
        // 起始預設的頁數(預設0
//        pageControl.currentPage = 0
        
        // 目前所在頁數的點點顏色
        pageControl.currentPageIndicatorTintColor = UIColor.black
        // 其餘頁數點的顏色
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
        // 增加一個值改變時的事件
        pageControl.addTarget(self,action: #selector(MainVC.pageChanged),for: .valueChanged)
        
        // 加入到基底的視圖中 (不是加到 UIScrollView 裡)，因為比較後面加入 所以會蓋在 UIScrollView 上面
        self.view.addSubview(pageControl)
        
    }
// MARK: - 頁數值
    func pages() {
        // 建立 5 個 UILabel 來顯示每個頁面內容
        for i in 0...4 {
            var myLabel = UILabel()
            myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: fullSize.width, height: 150)) //文字框大小
            myLabel.center = CGPoint(x: fullSize.width * (0.5 + CGFloat(i)),y: fullSize.height * 0.4) //前後文字間ㄉ距離
            myLabel.font = UIFont(name: "Helvetica-Bold", size: 48.0) // 字體、大小
            myLabel.textAlignment = .center // 文字置中
            myLabel.text = "\(i + 1)"
            myScrollView.addSubview(myLabel)
        }
    }
// MARK: - 滑動結束時
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // 左右滑動到新頁時 更新 UIPageControl 顯示的頁數
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = page
    }
// MARK: - 點擊 點 換頁
    @objc func pageChanged(sender: UIPageControl) {
        // 依照目前圓點在的頁數算出位置
        var frame = myScrollView.frame
        frame.origin.x = frame.size.width * CGFloat(sender.currentPage)
        frame.origin.y = 0
        
        // 再將 UIScrollView 滑動到該點
        myScrollView.scrollRectToVisible(frame, animated:true)
    }
}

// MARK: -
/*
 文字標籤 UILabel - https://itisjoe.gitbooks.io/swiftgo/content/uikit/uilabel.html
 與 UIPageControl 的應用 - https://itisjoe.gitbooks.io/swiftgo/content/uikit/uiscrollview.html
 CGRectMake, CGPointMake, CGSizeMake, CGRectZero, CGPointZero is unavailable in Swift -
 https://stackoverflow.com/questions/37946990/cgrectmake-cgpointmake-cgsizemake-cgrectzero-cgpointzero-is-unavailable-in-s
*/
