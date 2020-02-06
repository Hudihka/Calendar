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
    var months: [Month] = []

    init(date: Date) {

        self.numberYear = date.year

        let calendar = Calendar.current

        for i in 1...12{
            let dateMonth = DateComponents(calendar: calendar, year: self.numberYear, month: i).date!

            let month = Month(date: dateMonth, year: self.numberYear, numberMonth: i)

            self.months.append(month)

        }
    }


}



struct Month {

    var countLines: Int
    var days: [Day] = []

    var nameMonth: String

    var offset: Int = 0 //отступ для первого дня

    var isDiapazone = false //есть хоть один день в этом месяце что в диапазоне возможных дат
    

    init(date: Date, year: Int, numberMonth: Int) {
        self.countLines = date.weeksInMonth
        self.nameMonth = date.monthString

        let calendar = Calendar.current

        for i in 1...date.countDayInMonth {
            let dateDay = DateComponents(calendar: calendar, year: year, month: numberMonth, day: i).date!

            if i == 1 {
               self.offset = dateDay.nameDayMonth - 1
            }

            self.days.append(Day(date: dateDay, calendar: calendar, numberMonth: i))
        }
        
        if days.first(where: {$0.isDiapazone}) != nil {
            self.isDiapazone = true
        }
        
    }

    func dateInIndex(index: IndexPath) -> Date? {
        let index = index.row - offset

        return days[safe: index]?.date
    }

}


struct Day {

    var isWeekend    : Bool
    var isTooday     : Bool

    var numberWeekDay: Int
    var numberMonth  : Int
    
    var date         :Date

    var isDiapazone = false

    init(date: Date, calendar: Calendar, numberMonth: Int) {
        self.date          = date

        let dParser = DateParser.shared
        
        self.numberWeekDay = date.weeksInMonth
        self.numberMonth   = numberMonth

        self.isTooday      = calendar.isDateInToday(date)
        self.isWeekend     = calendar.isDateInWeekend(date)
        
        if date >= dParser.customFrom, date <= dParser.customTo {
            self.isDiapazone = true
        }
        
    }
}

