//
//  ViewController.swift
//  Test0714
//
//  Created by 侯懿玲 on 2021/7/13.
//

import UIKit
struct mvs {
    var image : UIImage?
    var date : String?
    var name : String?
    init(image: UIImage, date: String, name: String){
        self.image = image
        self.date = date
        self.name = name
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var movies = [mvs]()
    func moviesitem(){
        movies.append(mvs(image: UIImage(named:"引爆摩天樓")! , date: "1997年4月19日", name: "引爆摩天樓"))
        movies.append(mvs(image: UIImage(named:"第14號獵物")!, date: "1998年4月18日", name: "第14號獵物"))
        movies.append(mvs(image: UIImage(named:"世紀末的魔術師")!, date: "1999年4月17日", name: "世紀末的魔術師"))
        movies.append(mvs(image: UIImage(named:"瞳孔中的暗殺者")!, date: "2000年4月22日", name: "瞳孔中的暗殺者"))
        movies.append(mvs(image: UIImage(named:"往天國的倒數計時")!, date: "2001年4月21日", name: "往天國的倒數計時"))
        movies.append(mvs(image: UIImage(named:"貝克街的亡靈")!, date: "2002年4月20日", name: "貝克街的亡靈"))
        movies.append(mvs(image: UIImage(named:"迷宮的十字路")!, date: "2003年4月19日", name: "迷宮的十字路"))
        movies.append(mvs(image: UIImage(named:"銀翼的奇術師")!, date: "2004年4月17日", name: "銀翼的奇術師"))
        movies.append(mvs(image: UIImage(named:"水平線上的陰謀")!, date: "2005年4月9日", name: "水平線上的陰謀"))
        movies.append(mvs(image: UIImage(named:"偵探們的鎮魂歌")!, date: "2006年4月15日", name: "偵探們的鎮魂歌"))
        movies.append(mvs(image: UIImage(named:"紺碧之棺")!, date: "2007年4月21日", name: "紺碧之棺"))
        movies.append(mvs(image: UIImage(named:"戰慄的樂譜")!, date: "2008年4月19日", name: "戰慄的樂譜"))
        movies.append(mvs(image: UIImage(named:"漆黑的追跡者")!, date: "2009年4月18日", name: "漆黑的追跡者"))
        movies.append(mvs(image: UIImage(named:"魯邦三世VS名偵探柯南")!, date: "2009年3月27日", name: "魯邦三世VS名偵探柯南"))
        movies.append(mvs(image: UIImage(named:"天空的劫難船")!, date: "2010年4月17日", name: "天空的劫難船"))
        movies.append(mvs(image: UIImage(named:"沉默的15分鐘")!, date: "2011年4月16日", name: "沉默的15分鐘"))
        movies.append(mvs(image: UIImage(named:"第11位前鋒")!, date: "2012年4月14日", name: "第11位前鋒"))
        movies.append(mvs(image: UIImage(named:"絕海的偵探")!, date: "2013年4月20日", name: "絕海的偵探"))
        movies.append(mvs(image: UIImage(named:"魯邦三世VS名偵探柯南 THE MOVIE")!, date: "2013年12月7日", name: "魯邦三世VS名偵探柯南 THE MOVIE"))
        movies.append(mvs(image: UIImage(named:"異次元的狙擊手")!, date: "2014年4月19日", name: "異次元的狙擊手"))
        movies.append(mvs(image: UIImage(named:"江戶川柯南失蹤事件 ～史上最糟糕的兩天～")!, date: "2014年12月26日", name: "江戶川柯南失蹤事件 ～史上最糟糕的兩天～"))
        movies.append(mvs(image: UIImage(named:"業火的向日葵")!, date: "2015年4月18日", name: "業火的向日葵"))
        movies.append(mvs(image: UIImage(named:"純黑的惡夢")!, date: "2016年4月16日", name: "純黑的惡夢"))
        movies.append(mvs(image: UIImage(named:"Episode ONE 變小的名偵探")!, date: "2016年12月9日", name: "Episode ONE 變小的名偵探"))
        movies.append(mvs(image: UIImage(named:"唐紅的戀歌")!, date: "2017年4月15日", name: "唐紅的戀歌"))
        movies.append(mvs(image: UIImage(named:"零的執行人")!, date: "2018年4月13日", name: "零的執行人"))
        movies.append(mvs(image: UIImage(named:"紺青之拳")!, date: "2019年4月12日", name: "紺青之拳"))
        movies.append(mvs(image: UIImage(named:"紅之校外旅行")!, date: "2020年11月20日", name: "紅之校外旅行"))
        movies.append(mvs(image: UIImage(named:"緋色的不在場證明")!, date: "2021年2月11日", name: "緋色的不在場證明"))
        movies.append(mvs(image: UIImage(named:"緋色的彈丸")!, date: "2021年4月16日", name: "緋色的彈丸"))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // register cell
        let nibCell = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: "MyCollectionViewCell")
        
        moviesitem()
        // 重新將陣列資料載入tableview
        collectionView.reloadData()
    }
}

//擴充collectionView
extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as? MyCollectionViewCell
        cell!.ibImage.image = movies[indexPath.row].image
        cell!.ibdate.text = movies[indexPath.row].date
        cell!.ibname.text = movies[indexPath.row].name
        return cell!
    }
}
