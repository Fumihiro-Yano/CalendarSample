//
//  DateManager.swift
//  CalendarSample
//
//  Created by 矢野史洋 on 2016/05/03.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import Foundation
import UIKit

var currentMonthOfDates = [NSDate]() //セルに表示する日にちの配列
var selectedDate = NSDate()
let daysPerWeek: Int = 7
var numberOfItems: Int!

//NSDateの拡張
extension NSDate {
    func monthAgoDate() -> NSDate {
        let addValue = -1
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
    func monthLaterDate() -> NSDate {
        let addValue: Int = 1
        let calendar = NSCalendar.currentCalendar()
        let dateComponents = NSDateComponents()
        dateComponents.month = addValue
        return calendar.dateByAddingComponents(dateComponents, toDate: self, options: NSCalendarOptions(rawValue: 0))!
    }
    
}

class DateManager {
    
//月ごとのセルの数を返すメソッド
func daysAcquisition() -> Int {
    //指定の月がいくつ週を持っているのかを取得。print(rangeOfWeeks)出力結果：例(1,5)
    let rangeOfWeeks = NSCalendar.currentCalendar().rangeOfUnit(NSCalendarUnit.WeekOfMonth, inUnit: NSCalendarUnit.Month, forDate: firstDateOfMonth())
    //月が持つ週の数をlengthで取得。print(rangeOfWeeks.length)出力結果：例5
    let numberOfWeeks = rangeOfWeeks.length
    //週の数×列の数
    numberOfItems = numberOfWeeks * daysPerWeek
    return numberOfItems
}
    
//月の初日を取得するメソッド。
func firstDateOfMonth() -> NSDate {
    let components = NSCalendar.currentCalendar().components([.Year, .Month, .Day],
        fromDate: selectedDate)
    components.day = 1
    let firstDateMonth = NSCalendar.currentCalendar().dateFromComponents(components)!
    return firstDateMonth
}

//セルに表示する日にちの取得をするメソッド。
func dateForCellAtIndexPath(numberOfItems: Int) {
    // ①「月の初日が週の何日目か」を計算する
    let ordinalityOfFirstDay = NSCalendar.currentCalendar().ordinalityOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.WeekOfMonth, forDate: firstDateOfMonth())
    for var i = 0; i < numberOfItems; i++ {
        // ②「月の初日」と「indexPath.item番目のセルに表示する日」の差を計算する
        let dateComponents = NSDateComponents()
        dateComponents.day = i - (ordinalityOfFirstDay - 1)
        // ③ 表示する月の初日から②で計算した差を引いた日付を取得
        let date = NSCalendar.currentCalendar().dateByAddingComponents(dateComponents, toDate: firstDateOfMonth(), options: NSCalendarOptions(rawValue: 0))!
        // ④配列に追加
        currentMonthOfDates.append(date)
        }
    }
    
//取得した日にちの表記を日付だけで取得する。formatterでdを指定すると1日ずれる。ズレる理由は今の所なぞ、ズレてうまい具合にカレンダー表示とあってる。
func conversionDateFormat(indexPath: NSIndexPath) -> String {
    dateForCellAtIndexPath(numberOfItems)
    let formatter: NSDateFormatter = NSDateFormatter()
    formatter.locale = NSLocale(localeIdentifier: "ja_JP")
    formatter.dateFormat = "d"
    return formatter.stringFromDate(currentMonthOfDates[indexPath.row])
}
 
//前の月の表示
func prevMonth(date: NSDate) -> NSDate {
        currentMonthOfDates = []
        selectedDate = date.monthAgoDate()
        return selectedDate
}
//次の月の表示
func nextMonth(date: NSDate) -> NSDate {
        currentMonthOfDates = []
        selectedDate = date.monthLaterDate()
        return selectedDate
}

}