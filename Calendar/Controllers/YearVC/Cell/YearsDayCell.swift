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

    let parser = DateParser.shared
    
    var day: Date? {
        didSet{
            desingView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    private func desingView(){

        clearView()

        guard let day = day else {
            return
        }

        let isYearsVC = UIApplication.shared.workVC is YearViewController

        //габариты лейбла

        let sizeLabel = isYearsVC ? widthDayInMonth : 0.8 * widthDay
        constreintWidthCell.constant = sizeLabel

        labelDay.addRadius(number: sizeLabel * 0.5)
        labelDay.layer.borderWidth = isYearsVC ? 0.5 : 2


        labelDay.text = day.dayNumber
        labelDay.alpha = parser.dateInDiapason(date: day) ? 1 : 0.3

        labelDay.textColor = day.isWeekend ? colorWekend : colorDay
        
        //ширифт

        let sizeFont: CGFloat = isYearsVC ? 9 : 18
        labelDay.font = UIFont.systemFont(ofSize: sizeFont, weight: .medium)

        //округлениие вью

        if day.isTooDay {
            labelDay.layer.borderColor = colorDay.cgColor
        }

        selected(date: day)
    }

    private func selected(date: Date){

        let dataParser = DateParser.shared

        if let oneSelected = dataParser.selectedDataOne, oneSelected == date{
            settingsLabelSelected(from: true)
            return
        }

        if let twoSelected = dataParser.selectedDataTwo, twoSelected == date {
            settingsLabelSelected(from: false)
            return
        }

        if dataParser.dateInDiapasonSelected(date: date){
            rightView.backgroundColor = selectedView
            leftView.backgroundColor = selectedView
        }

    }

    private func settingsLabelSelected(from: Bool){
        labelDay.textColor = UIColor.white
        labelDay.backgroundColor = colorWekend

        guard let dataOne = DateParser.shared.selectedDataTwo,
              let dataTwo = DateParser.shared.selectedDataOne,
              dataOne != dataTwo else {
            return
        }

        if from {
            rightView.backgroundColor = selectedView
        } else {
            leftView.backgroundColor = selectedView
        }

    }

    private func clearView(){

        labelDay.text = ""
        labelDay.layer.borderColor = UIColor.clear.cgColor


        labelDay.backgroundColor = UIColor.clear
        labelDay.textColor = UIColor.black

        leftView.backgroundColor = UIColor.clear
        rightView.backgroundColor = UIColor.clear
    }

}
