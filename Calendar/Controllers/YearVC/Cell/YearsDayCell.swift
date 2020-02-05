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
    @IBOutlet weak var constreintWidthCell: NSLayoutConstraint!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
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

        let isYearsVC = UIApplication.shared.workVC is YearViewController

        //габариты лейбла

        let sizeLabel = isYearsVC ? widthDayInMonth : 0.8 * widthDay
        constreintWidthCell.constant = sizeLabel

        labelDay.addRadius(number: sizeLabel * 0.5)

        labelDay.layer.borderWidth = isYearsVC ? 0.5 : 2

        guard let day = day else {
            labelDay.text = ""
            labelDay.layer.borderColor = UIColor.clear.cgColor
            return
        }


        labelDay.text = "\(day.numberMonth)"
        labelDay.alpha = day.isDiapazone ? 1 : 0.3

        labelDay.textColor = day.isWeekend ? UIColor.red : UIColor.black
        
        //ширифт

        let sizeFont: CGFloat = isYearsVC ? 9 : 18
        labelDay.font = UIFont.systemFont(ofSize: sizeFont, weight: .medium)

        //округлениие вью

        labelDay.layer.borderColor = day.isTooday ? UIColor.black.cgColor : UIColor.clear.cgColor

        
    }

}
