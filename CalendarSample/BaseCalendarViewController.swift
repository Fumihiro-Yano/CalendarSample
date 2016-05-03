//
//  ViewController.swift
//  CalendarSample
//
//  Created by 矢野史洋 on 2016/05/02.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

let reuseIdentifier = "BaseCalendarCollectionViewCell"
let cellMargin:CGFloat = 2.0
let cellLineCount:NSInteger = 7
let weekArray = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

class BaseCalendarViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var calendarCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarCollectionView.registerNib(UINib(nibName: "BaseCalendarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        calendarCollectionView.delegate = self
        calendarCollectionView.dataSource = self
//        calendarCollectionView.collectionViewLayout = BaseCalendarViewLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return cellLineCount
        }else {
            return 30
        }
}
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((self.view.frame.width - cellMargin * CGFloat(cellLineCount))/CGFloat(cellLineCount), 75)
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : BaseCalendarCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! BaseCalendarCollectionViewCell
        cell.collectionLabel?.text = "10"
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }



}

