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

    var numberYear: Int
//    var sizeCell: [CGSize]
    var months: [Month] = []

    init(date: Date) {
        self.numberYear = date.year

        let calendar = Calendar.current

        for i in 1...12{
            let dateMonth = DateComponents(calendar: calendar, year: self.numberYear, month: i).date!

            let month = Month(date: dateMonth, year: self.numberYear, numberMonth: i)

            self.months.append(month)

        }

//        let arrayCoutLines = self.months.map({$0.countLines})
//
//        let one3Month = CGFloat(arrayCoutLines.prefix(3).max() ?? 5) * widthDayInMonth
//        let two3Month = CGFloat(arrayCoutLines[3..<5].max() ?? 5) * widthDayInMonth
//        let three3Month = CGFloat(arrayCoutLines[5..<7].max() ?? 5) * widthDayInMonth
//        let four3Month = CGFloat(arrayCoutLines.suffix(3).max() ?? 5) * widthDayInMonth
//
//        let sizeOne = CGSize(width: widthMonth, height: one3Month)
//        let sizeTwo = CGSize(width: widthMonth, height: two3Month)
//        let sizeThree = CGSize(width: widthMonth, height: three3Month)
//        let sizeFour = CGSize(width: widthMonth, height: four3Month)
//
//
//        sizeCell = [sizeOne, sizeOne, sizeOne,
//                    sizeTwo, sizeTwo, sizeTwo,
//                    sizeThree, sizeThree, sizeThree,
//                    sizeFour, sizeFour, sizeFour]



    }


}



struct Month {

    var countLines: Int
    var days: [Day] = []

    var nameMonth: String

    var offset: Int = 1 //отступ для первого дня

    var countCell: Int {
        return days.count + offset
    }

    init(date: Date, year: Int, numberMonth: Int) {
        self.countLines = date.weeksInMonth
        self.nameMonth = date.monthString

        let calendar = Calendar.current

        for i in 1...date.countDayInMonth{
            let dateDay = DateComponents(calendar: calendar, year: year, month: numberMonth, day: i).date!

            if i == 1 {
                self.offset = dateDay.nameDayMonth
            }
            self.days.append(Day(date: dateDay, calendar: calendar, numberMonth: i))
        }
    }

}


struct Day {

    var isWeekend    : Bool
    var isTooday     : Bool

    var numberWeekDay: Int
    var numberMonth  : Int

    init(date: Date, calendar: Calendar, numberMonth: Int) {
        self.numberWeekDay = date.weeksInMonth
        self.numberMonth   = numberMonth

        self.isTooday      = calendar.isDateInToday(date)
        self.isWeekend     = calendar.isDateInWeekend(date)
    }
}

