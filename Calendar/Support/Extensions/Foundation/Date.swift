//
//  Date.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension Date {

    init(day: Int?, month: Int?, year: Int?) {

        guard let day = day, let month = month, let year = year else {
            self = Date()
            return
        }

        if month < 13, month > 0, day > 0, year > 0, let date = "\(day) \(month) \(year)".getDatwToString("dd MM yyyy") {
            self = Date(timeInterval: 0, since: date)
            return
//            self.init(timeInterval: 0, since: date)
        }

        self = Date()
    }

    init(day: String, month: String, year: String) {
        self.init(day: Int(day), month: Int(month), year: Int(year))
    }



    func printDate(format: String = "d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }

    var todayDate: String {

        let today = Date().printDate(format: "d.MM.yyyy")
        let date = self.printDate(format: "d.MM.yyyy")

        if today == date {
            return self.printDate(format: "HH:mm")
        } else {
            return date
        }
    }

    //количество дней в этом месяце

    var countDayInMonth: Int {

        let dateComponents = DateComponents(year: self.year, month: self.monthNumber)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!

        let range = calendar.range(of: .day, in: .month, for: date)!

        return range.count

    }


    //КОЛИЧЕСТВО ПОЛНЫХ НЕДЕЛЬ

    var weeksInMonth: Int {

        let month = self.monthNumber
        let year = self.year


        let dateString = String(format: "%4d/%d/01", year, month)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        if let date = dateFormatter.date(from: dateString), let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian){
            calendar.firstWeekday = 2 // Monday
            let weekRange = calendar.range(of: .weekOfMonth, in: .month, for: date)
            let weeksCount = weekRange.length
            return weeksCount
        } else {
            return 5
        }

    }



    var year: Int {
        let str = self.printDate(format: "yyyy")
        return Int(str)!
    }

    var day: Int {
        let str = self.printDate(format: "d")
        return Int(str)!
    }

    var monthString: String{
        return self.printDate(format: "MMMM")
    }

    var monthNumber: Int{
        let str = self.printDate(format: "M")
        return Int(str)!
    }

    //номер дня в неделе
    var nameDayMonth: Int {
        return Int(self.printDate(format: "e"))!
    }

    //это выходной

    var isWeekend: Bool {
        return self.nameDayMonth > 5
    }


//    var isToDay: Bool{
//        return Calendar.current.isDateInToday(self)
//    }


}
