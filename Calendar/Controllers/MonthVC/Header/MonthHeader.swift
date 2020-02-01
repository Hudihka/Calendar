//
//  MonthHeader.swift
//  Calendar
//
//  Created by Hudihka on 02/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class MonthHeader: UICollectionReusableView {
    
    @IBOutlet var collectionLabels: [UILabel]!
    
    var month: Month? {
        didSet{
            if let month = month {
                let label = collectionLabels[month.offset]
                label.text = month.nameMonth
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionLabels.forEach({$0.text = nil})
    }
    
}
