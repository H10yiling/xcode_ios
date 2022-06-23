//
//  SecondVC.swift
//  Bingo
//
//  Created by 侯懿玲 on 2022/5/22.
//

import UIKit

class SecondVC: UIViewController {
    
    @IBOutlet weak var segGameOrInput: UISegmentedControl!
    @IBOutlet weak var txfMinNumber: UITextField!
    @IBOutlet weak var txfMaxNumber: UITextField!
    @IBOutlet weak var btnRandomNumber: UIButton!
    @IBOutlet weak var cvBingo: UICollectionView!
    
    @IBOutlet weak var svSet: UIStackView!
    
    /// 取得螢幕尺寸
    let fullScreenSize = UIScreen.main.bounds.size
    /// CollectionView的Layout
    let layout = UICollectionViewFlowLayout()
    /// Cell與Cell間的間距
    var cellLineSpacing: CGFloat = 5
    
    var viewModelSecond: SecondViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSecondVCInit()
        monitorUIControlEvent()
        monitorPublisherEvent()
        addGestureRecognizer()
    }
    
    /// 設定 ViewModel
    func withViewModel(viewModel: SecondViewModel) -> SecondVC {
        viewModelSecond = viewModel
        return self
    }
    
    /// SecondVC初始化設定
    func setSecondVCInit() {
        setUIInit()
        registerCell()
        setCellSize()
        
    }
    
    /// set UI
    func setUIInit() {
        // UISegmentedControl
        segGameOrInput.setTitle("遊戲", forSegmentAt: 0)
        segGameOrInput.setTitle("輸入", forSegmentAt: 1)
        segGameOrInput.selectedSegmentIndex = 1         // 進入遊戲畫面後，Segment是輸入模式
        
        // UITextField
        // 最小值輸入匡設定
        txfMinNumber.placeholder = "min"
        txfMinNumber.keyboardType = .numberPad
        txfMinNumber.text = "\(1)"
        // 最大值輸入匡設定
        txfMaxNumber.placeholder = "max"
        txfMaxNumber.keyboardType = .numberPad
        txfMaxNumber.text = "\(200)"
        
        // UIButton
        btnRandomNumber.setTitle("亂數", for: .normal)
        btnRandomNumber.layer.cornerRadius = 5.0
        btnRandomNumber.backgroundColor = .darkGray
        btnRandomNumber.tintColor = .white
        
        // UICollectionView
        // 是否啟用滾動
        cvBingo.isScrollEnabled = false
    }
    
    /// register cell
    func registerCell() {
        let nibCell = UINib(nibName: "BingoCVC", bundle: nil)
        cvBingo.register(nibCell, forCellWithReuseIdentifier: "BingoCVC")
    }
    
    /// 設定CollectionView的layout
    func setCellSize() {
        // 設置間距
        layout.minimumInteritemSpacing = cellLineSpacing   // 同一行中的項目之間使用的最小間距
        layout.minimumLineSpacing = cellLineSpacing        // 網格中項目行之間使用的最小間距
        cvBingo.collectionViewLayout = layout
    }
    
    /// 設置監聽 UI 事件
    func monitorUIControlEvent() {
        // 遊戲模式切換
        segGameOrInput.publisher(for: .valueChanged).sink { [unowned self] _ in
            viewModelSecond.setBingoGameMode(segmentIndex: segGameOrInput.selectedSegmentIndex)
            
        }.store(in: &viewModelSecond.aryMonitorStore)

        
        // 亂數按鈕點擊
        btnRandomNumber.publisher(for: .touchUpInside).sink { [unowned self] _ in
            // 產生出亂數
            //viewModelSecond.randomNumberGenerator()
        }.store(in: &viewModelSecond.aryMonitorStore)
        
    }
    
    /// 設置監聽事件
    func monitorPublisherEvent() {
        // 遊戲模式（設定）
        viewModelSecond.$gameMode.filter { $0 == .setUp }.sink { [self] _ in
            // 遊戲模式中不可以進行設定調整
            svSet.isUserInteractionEnabled = true
            
            // 設定模式中不顯示連線數量
            //vLines.isHidden = true
            //lbLines.text = ""
            
            // 重置選擇狀態
            //m_viewModel.initSelectedMatrix()
        }.store(in: &viewModelSecond.aryMonitorStore)
        
        // 遊戲模式（遊戲）
        viewModelSecond.$gameMode.filter { $0 == .game }.sink { [self] _ in
            // 遊戲模式中不可以進行設定調整
            svSet.isUserInteractionEnabled = false
            
            // 設定模式中不顯示連線數量
            //vLines.isHidden = true
            //lbLines.text = ""
            
            // 重置選擇狀態
            //m_viewModel.initSelectedMatrix()
        }.store(in: &viewModelSecond.aryMonitorStore)

        
        // 亂數按鈕點擊
        btnRandomNumber.publisher(for: .touchUpInside).sink { [unowned self] _ in
            // 產生出亂數
            //viewModelSecond.randomNumberGenerator()
        }.store(in: &viewModelSecond.aryMonitorStore)
        
    }
    
}

extension SecondVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    // 設定 collection view 有 1 個 section
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 輸出幾*幾的賓果盤
        return viewModelSecond.gameSize * viewModelSecond.gameSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BingoCVC", for: indexPath) as! BingoCVC
        let columnX = indexPath.row % viewModelSecond.gameSize  // 第幾列Column
        let rowY    = indexPath.row / viewModelSecond.gameSize  // 第幾行Row
        print("columnX,rowY",columnX,rowY)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        /// cellSize =  ( collectionView的寬 ) - ( cell的間距大小 ) * ( 間距數量 ) / ( 一個Row 幾個cell )
        let cellSize = ( Int(cvBingo.frame.size.width) - ( Int(cellLineSpacing) * (viewModelSecond.gameSize - 1) ) ) / viewModelSecond.gameSize
        //print("cvBingo.frame.size.width: ",cvBingo.frame.size.width,"cellSize: ",cellSize)
        
        // cell的寬、高
        return CGSize(width: cellSize, height: cellSize)
    }
}


// MARK: -

/*
 
 /// 設定CollectionView的layout
 func setCellSize() {
     
     // 設定albumCollectionView起始位置
     layout = cvBingo.collectionViewLayout as? UICollectionViewFlowLayout
     // 將 estimatedItemSize 設為 .zero， cell 的尺寸才會依據 itemSize，否則它將從 auto layout 的條件計算 cell 的尺寸
     layout.estimatedItemSize = .zero
     
     // 設置間距
     layout.minimumInteritemSpacing = cellLineSpacing   // 同一行中的項目之間使用的最小間距
     layout.minimumLineSpacing = cellLineSpacing        // 網格中項目行之間使用的最小間距
     
     let num = viewModelSecond.gameSize
     // Cell的長寬
     let width = Double((fullScreenSize.width - layout.minimumInteritemSpacing*2)/CGFloat(num))
     // 設置每個 cell 的尺寸
     layout?.itemSize = CGSize(width: width, height: width)
     
     cvBingo.collectionViewLayout = layout
 }
 
 */
