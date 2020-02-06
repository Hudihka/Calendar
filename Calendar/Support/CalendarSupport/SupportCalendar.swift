//
//  SupportCalendar.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit


struct Year {

    let cashe = CasheDate.shared
    var numberYear: Int
    var months: [Month] = []

    init(date: Date) {

        self.numberYear = date.year

        for i in 1...12{

            let month = cashe.getMonth(year: date.year, month: i) ?? cashe.createMonth(year: date.year, monthInt: i)

            self.months.append(month)

        }
    }


}



class Month {

    var days: [Date] = []
    var nameMonth: String
    var offset: Int = 0 //отступ для первого дня
    var isDiapazone = false //есть хоть один день в этом месяце что в диапазоне возможных дат

    init(date: Date, year: Int, numberMonth: Int) {
        self.nameMonth = date.monthString
        self.offset = Date(day: 1, month: numberMonth, year: year).nameDayMonth - 1
        self.days = date.daysArrayDate(yerar: year, month: numberMonth)
        self.isDiapazone = DateParser.shared.monthInDiapason(date: self.days)
    }

    func dateInIndex(index: IndexPath) -> Date? {
        let index = index.row - offset
        return days[safe: index]
    }

}


