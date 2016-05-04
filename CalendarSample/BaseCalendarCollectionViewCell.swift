//
//  BaseCalendarCollectionViewCell.swift
//  CalendarSample
//
//  Created by 矢野史洋 on 2016/05/02.
//  Copyright © 2016年 矢野史洋. All rights reserved.
//

import UIKit

class BaseCalendarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionLabel: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
