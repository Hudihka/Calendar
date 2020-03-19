//
//  SupportCalendar.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import Foundation
import UIKit



struct Month {

    var days: [Date] = []
    var nameMonth: String
    var offset: Int = 0 //отступ для первого дня

    init(date: Date, year: Int, numberMonth: Int) {
        self.nameMonth = date.monthString
        self.offset = Date(day: 1, month: numberMonth, year: year).nameDayMonth - 1
        self.days = date.daysArrayDate(yerar: year, month: numberMonth)
    }

}


