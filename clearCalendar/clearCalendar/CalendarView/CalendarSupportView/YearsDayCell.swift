//
//  YearsDayCell.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

protocol SelectedDateCell: class {
    func selectedDate(_ date: Date)
}

class YearsDayCell: UICollectionViewCell {


    @IBOutlet weak var labelDay: UILabel!
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!

    let parser = DateParser.shared

    @IBOutlet weak var buttonSelected: UIButton!
    weak var delegate: SelectedDateCell?
    
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

        //габариты лейбла

        let radius = self.frame.width * 0.4

        labelDay.addRadius(number: radius)
        labelDay.layer.borderWidth = 2


        labelDay.text = day.dayNumber

        let isDiapasone = parser.dateInDiapason(date: day)

        if isDiapasone {
            buttonSelected.isEnabled = true
        }

//        labelDay.alpha = isDiapasone ? 1 : 0.15
        //labelDay.textColor = day.isWeekend ? red : UIColor.white

        labelDay.textColor = textColorLabel(isDiapazone: isDiapasone, isWeekend: day.isWeekend)

        //округлениие вью

        if day.isTooDay {
            labelDay.layer.borderColor = CConstants.cirkle.cgColor
        }

        selected(date: day)
    }

    private func textColorLabel(isDiapazone: Bool, isWeekend: Bool) -> UIColor{
        if isWeekend{
            return isDiapazone ? CConstants.wekend : CConstants.wekendNoDiapasone
        } else {
            return isDiapazone ? CConstants.weekdays : CConstants.wekendNoDiapasone
        }


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
            rightView.backgroundColor = CConstants.selectedView
            leftView.backgroundColor = CConstants.selectedView
        }

    }

    private func settingsLabelSelected(from: Bool){
        labelDay.textColor = UIColor.white
        labelDay.backgroundColor = CConstants.selectedViewExtreme

        guard let dataOne = DateParser.shared.selectedDataTwo,
              let dataTwo = DateParser.shared.selectedDataOne,
              dataOne != dataTwo else {
            return
        }

        if from {
            rightView.backgroundColor = CConstants.selectedView
        } else {
            leftView.backgroundColor = CConstants.selectedView
        }

    }

    private func clearView(){

        labelDay.text = ""
        labelDay.layer.borderColor = UIColor.clear.cgColor

        buttonSelected.isEnabled = false

        labelDay.backgroundColor = UIColor.clear
        labelDay.textColor = UIColor.black

        leftView.backgroundColor = UIColor.clear
        rightView.backgroundColor = UIColor.clear
    }

    @IBAction func buttonSelect(_ sender: Any) {

        if let date = day {
            self.delegate?.selectedDate(date)
        }

    }
}
