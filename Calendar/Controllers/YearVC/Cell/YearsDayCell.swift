//
//  YearsDayCell.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class YearsDayCell: UICollectionViewCell {


    @IBOutlet weak var labelDay: UILabel!

    var day: Day? {
        didSet{
            desingView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    private func desingView(){

        guard let day = day else {
            labelDay.text = ""
            return
        }

        labelDay.text = "\(day.numberMonth)"
        labelDay.alpha = day.isDiapazone ? 1 : 0.3
    }

}
