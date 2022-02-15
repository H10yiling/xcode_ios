//
//  MainViewController.swift
//  UITest0214
//
//  Created by Defalt Lee on 2022/2/14.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var safeAreaInset: UIEdgeInsets?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        safeAreaInset = UIApplication.shared.windows.first?.safeAreaInsets
        
        setCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        addViewOnCollectionView()
    }
    
    func setCollectionView() {
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        setCollectionViewLayout()
        
        registerCollectionViewCell()
    }
    
    func registerCollectionViewCell() {
        var nib: UINib?
        
        nib = UINib(nibName: MyCollectionViewCell.cellIdentifier, bundle: nil)
        myCollectionView.register(nib, forCellWithReuseIdentifier: MyCollectionViewCell.cellIdentifier)
    }
    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: topView.frame.height - safeAreaInset!.top + 110, left: 2, bottom: 0, right: 2)
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 2
        
        myCollectionView.collectionViewLayout = layout
    }
    
    func addViewOnCollectionView() {
        let containerView = UIView(frame: CGRect(x: 2, y: topView.frame.height - safeAreaInset!.top + 4, width: UIScreen.main.bounds.width - 4, height: 102))
        containerView.backgroundColor = .yellow
        
        let viewA = UIView(frame: CGRect(x: -2, y: 4, width: UIScreen.main.bounds.width, height: 45))
        viewA.backgroundColor = .red
        
        let viewB = UIView(frame: CGRect(x: -2, y: 53, width: UIScreen.main.bounds.width, height: 45))
        viewB.backgroundColor = .green
        
        containerView.addSubview(viewA)
        containerView.addSubview(viewB)
        myCollectionView.addSubview(containerView)
        
        // 放棄自動約束
        viewB.translatesAutoresizingMaskIntoConstraints = false
        
        // 綠色頂到藍色底的距離必須大於等於0
        let consTopOne = NSLayoutConstraint(item: viewB,
                                            attribute: .top,
                                            relatedBy: .greaterThanOrEqual,
                                            toItem: topView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: 0)
        
        // 設定約束的優先權
        consTopOne.priority = UILayoutPriority(1000)    // 沒給預設也會是 1000
        
        // 綠色底到黃色底的距離必須等於-4
        let consTopTwo = NSLayoutConstraint(item: viewB,
                                            attribute: .bottom,
                                            relatedBy: .equal,
                                            toItem: containerView,
                                            attribute: .bottom,
                                            multiplier: 1,
                                            constant: -4)
        
        // 設定約束的優先權
        consTopTwo.priority = UILayoutPriority(999)
        
        // 放棄自動約束後必須補全所有約束
        
        // 置中約束
        let consCenter = NSLayoutConstraint(item: viewB, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        // 高度約束
        let consHeight = NSLayoutConstraint(item: viewB, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 45)
        // 寬度約束
        let consWidth = NSLayoutConstraint(item: viewB, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: UIScreen.main.bounds.width)
        
        // 加入約束
        self.view.addConstraints([consTopOne, consTopTwo, consCenter, consHeight, consWidth])

        
        
    }

}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.cellIdentifier, for: indexPath) as! MyCollectionViewCell
        cell.cellView.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width - 12) / 3, height: (UIScreen.main.bounds.width - 12) / 3)
    }
    
}
