//
//  ViewController.swift
//  CalendarSample
//
//  Created by 矢野史洋 on 2016/05/02.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

let dateManager = DateManager()
let reuseIdentifier = "BaseCalendarCollectionViewCell"
let cellMargin:CGFloat = 2.0
let cellLineCount:NSInteger = 7
let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

class BaseCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendarDayLabel: UILabel!
    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarDayLabel.text = changeHeaderTitle(dateManager.firstDateOfMonth())
        calendarCollectionView.registerNib(UINib(nibName: "BaseCalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
//        calendarCollectionView.collectionViewLayout = BaseCalendarViewLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //headerの月を変更
    func changeHeaderTitle(date: NSDate) -> String {
        let formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "yyyy年MM月"
        let selectMonth = formatter.stringFromDate(date)
        return selectMonth
    }
    
    @IBAction func tappedHeaderPrevBtn(sender: UIButton) {
        selectedDate = dateManager.prevMonth(selectedDate)
        calendarCollectionView.reloadData()
        calendarDayLabel.text = changeHeaderTitle(selectedDate)
    }
    
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
        if section == 0 {
            return cellLineCount
        }else {
            return dateManager.daysAcquisition()
        }
}
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((self.view.frame.width - cellMargin * CGFloat(cellLineCount))/CGFloat(cellLineCount), 75)
    }
    
    //セルの垂直方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }
    
    //セルの水平方向のマージンを設定
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return cellMargin
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : BaseCalendarCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaseCalendarCollectionViewCell
        
        if (indexPath.row % 7 == 0) {
            cell.collectionLabel?.textColor = UIColor.lightRed()
        } else if (indexPath.row % 7 == 6) {
            cell.collectionLabel?.textColor = UIColor.lightBlue()
        } else {
            cell.collectionLabel?.textColor = UIColor.grayColor()
        }
        //テキスト配置
        if indexPath.section == 0 {
            cell.collectionLabel?.text = weekArray[indexPath.row]
        } else {
            cell.collectionLabel?.text = dateManager.conversionDateFormat(indexPath)
            //月によって1日の場所は異なる(後ほど説明します)
        }
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }



}

