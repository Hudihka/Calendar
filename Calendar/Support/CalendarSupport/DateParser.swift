//
//  DateParser.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class DateParser {

    static let shared = DateParser()

    var dateFrom: Date? = Date(day: 1, month: 1, year: 2019)
    var dateTo: Date? = Date(day: 1, month: 1, year: 2023)

    var arrayYears: [Year] {

        let countSeconds: Double = 3600 * 10 * 365

        let customFrom = dateFrom ?? Date(timeInterval: -1 * (countSeconds), since: Date())
        let customTo = dateTo ?? Date(timeInterval: countSeconds, since: Date())

        if customFrom > customTo {
            return []
        }

        let calendar = Calendar.current
        var years: [Year] = []

        for i in customFrom.year...customTo.year{
            if let dateYear = DateComponents(calendar: calendar, year: i).date {
                let year = Year(date: dateYear)
                years.append(year)
            }
        }

        return years
    }





}
