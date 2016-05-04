//
//  ViewController.swift
//  CalendarSample
//
//  Created by 矢野史洋 on 2016/05/02.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

//定数
let dateManager = DateManager()
let reuseIdentifier = "BaseCalendarCollectionViewCell"
let cellMargin:CGFloat = 2.0
let cellHeight:CGFloat = 75
let cellLineCount:NSInteger = 7
let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

class BaseCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendarDayLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ヘッダー部分のラベルに、年と月だけの形に変えたselectedDateをセット
        calendarDayLabel.text = changeHeaderTitle(selectedDate)
        calendarCollectionView.registerNib(UINib(nibName: "BaseCalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
        //カスタムレイアウトは使わない。一旦
//        calendarCollectionView.collectionViewLayout = BaseCalendarViewLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //ヘッダー部分のラベルの部分に表示するフォーマットに帰るメソッド
    func changeHeaderTitle(date: NSDate) -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        let selectMonth = formatter.stringFromDate(date)
        return selectMonth
    }
    
    //前の月を表示するボタンのアクションメソッド
    @IBAction func tappedHeaderPrevBtn(sender: UIButton) {
        selectedDate = dateManager.prevMonth(selectedDate)
        calendarCollectionView.reloadData()
        calendarDayLabel.text = changeHeaderTitle(selectedDate)
    }
    
    //次の月を表示するボタンのアクションメソッド
    @IBAction func tappedHeaderNextBtn(sender: UIButton) {
        selectedDate = dateManager.nextMonth(selectedDate)
        calendarCollectionView.reloadData()
        calendarDayLabel.text = changeHeaderTitle(selectedDate)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //セクション0：曜日　セクション1：各月の曜日分のセル数
        if section == 0 {
            return cellLineCount
        }else {
            return dateManager.daysAcquisition()
        }
}
    
    //セルの大きさをきめるメソッド
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        //セルのwidthは端末に合わせてぴったり7つ並ぶように指定。
        return CGSizeMake((self.view.frame.width - cellMargin * CGFloat(cellLineCount))/CGFloat(cellLineCount), cellHeight)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }

    //セルのテキストや色を指定するメソッド
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : BaseCalendarCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaseCalendarCollectionViewCell
        
        if (indexPath.row % 7 == 0) {
            cell.collectionLabel?.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.collectionLabel?.textColor = UIColor.lightBlue()
        } else {
            cell.collectionLabel?.textColor = UIColor.grayColor()
        }
        
        //テキスト指定
        if indexPath.section == 0 {
            //曜日のテキスト
            cell.collectionLabel?.text = weekArray[indexPath.row]
        } else {
            //日にちのテキスト
            cell.collectionLabel?.text = dateManager.conversionDateFormat(indexPath)
        }
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }



}

