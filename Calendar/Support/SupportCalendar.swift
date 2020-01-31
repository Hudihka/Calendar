//
//  SupportCalendar.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation


struct DateCalendar {
    var year: UInt
    var day: UInt

    var monthInt: UInt
    var monthString: String

    var weekDay: UInt

    var date: Date

    init(date: Date){
        self.date = date

        self.year        = UInt(date.printDate(format: "yyyy")) ?? 2020
        self.monthInt    = UInt(date.printDate(format: "M")) ?? 1
        self.day         = UInt(date.printDate(format: "d")) ?? 1
        self.weekDay     = UInt(date.printDate(format: "e")) ?? 1

        self.monthString = date.printDate(format: "MMMM")
    }
}



struct Month {

    var countLines: Int

    var countCell: Int {
        let c = countLines * 7
        return c - 1
    }



    var date: Date




}


struct Day {

    var isWeekend    : Bool
    var numberWeekDay: Int
    var numberMonth  : Int

    init(date: Date) {
        self.numberWeekDay = Int(date.printDate(format: "d")) ?? 1
        self.numberMonth   = Int(date.printDate(format: "e")) ?? 1

        self.isWeekend     = self.numberMonth > 5
    }
}





//func weeksInMonth(month: Int, forYear year: Int) -> Int? {
//
//    if (month < 1 || month > 12) { return nil }
//
//    let dateString = String(format: "%4d/%d/01", year, month)
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy/MM/dd"
//    if let date = dateFormatter.date(from: dateString), let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian){
//        calendar.firstWeekday = 2 // Monday
//        let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: date)
//        let weeksCount = weekRange.length
//        return weeksCount
//    } else {
//        return nil
//    }
//}
