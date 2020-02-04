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

        guard let day = day else {
            labelDay.text = ""
            return
        }
        
        let isYearsVC = UIApplication.shared.workVC is YearViewController

        labelDay.text = "\(day.numberMonth)"
        labelDay.alpha = day.isDiapazone ? 1 : 0.3

        labelDay.textColor = day.isWeekend ? UIColor.red : UIColor.black
        
        //ширифт

        let sizeFont: CGFloat = isYearsVC ? 9 : 18
        labelDay.layer.borderColor = UIColor.clear.cgColor
        labelDay.font = UIFont.systemFont(ofSize: sizeFont, weight: .medium)
        
        //габариты лейбла
        
        let sizeLabel = isYearsVC ? widthDayInMonth : 0.8 * widthDay
        constreintWidthCell.constant = sizeLabel
        
        //округлениие вью
        
        labelDay.cirkleView()
        labelDay.layer.borderWidth = 2
        
        labelDay.layer.borderColor = day.isTooday ? UIColor.clear.cgColor : UIColor.black.cgColor
        
    }

}
