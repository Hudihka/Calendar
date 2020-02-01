//
//  YearsMonthCell.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class YearsMonthCell: UICollectionViewCell {

    @IBOutlet weak var labelMonth: UILabel!

    var month: Month? {
        didSet{
            let text = month?.nameMonth ?? Date().monthString
            labelMonth.text = text
        }
    }



    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
