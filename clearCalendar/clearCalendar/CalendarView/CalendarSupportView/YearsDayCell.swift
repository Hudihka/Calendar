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

        labelDay.layer.cornerRadius = radius
        labelDay.layer.masksToBounds = true
        labelDay.layer.borderWidth = 2


        labelDay.text = day.dayNumber

        let isDiapasone = parser.dateInDiapason(date: day)

        if isDiapasone {
            buttonSelected.isEnabled = true
        }


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

        if date == parser.getSelectedDate(true){
            settingsLabelSelected(from: true)
            return
        }

        if date == parser.getSelectedDate(false) {
            settingsLabelSelected(from: false)
            return
        }

        if parser.dateInDiapasonSelected(date: date){
            rightView.backgroundColor = CConstants.selectedView
            leftView.backgroundColor = CConstants.selectedView
        }

    }

    private func settingsLabelSelected(from: Bool){
        labelDay.textColor = UIColor.white
        labelDay.backgroundColor = CConstants.selectedViewExtreme

        guard let dataOne = parser.getSelectedDate(true),
              let dataTwo = parser.getSelectedDate(false),
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
        if CConstants.selectedDate, let date = day {
            self.delegate?.selectedDate(date)
        }
    }
}
