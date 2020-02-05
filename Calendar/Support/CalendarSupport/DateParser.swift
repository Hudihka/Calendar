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

    var dateFrom: Date? = Date(day: 1, month: 2, year: 2019)
    var dateTo: Date? = Date(day: 10, month: 6, year: 2023)

    /*
     если селектДата1 есть значение а селектДата2 нет
     то дата 1 является конечной

     если есть оба эти значения и пользаватель нажимает еще раз
     эти оба значения сбрасываютя

     */

    var selectedDataOne: Date? = nil
    var selectedDataTwo: Date? = nil
    
    
    private let countSeconds: Double = 100000
    
    var customFrom: Date {
        return dateFrom ?? Date(timeInterval: -1 * (countSeconds), since: Date())
    }
    
    var customTo: Date {
        return dateTo ?? Date(timeInterval: countSeconds, since: Date())
    }

    func dateInDiapason(date: Date) -> Bool {
        if customFrom <= date, date <= customTo {
            return true
        }

        return false
    }
    

    var arrayYears: [Year] {

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
    
    var arrayMonth: [Month] {

        if customFrom > customTo {
            return []
        }

        var month: [Month] = []

        for obj in self.arrayYears {
            let montArray = obj.months.filter({$0.isDiapazone})
            month += montArray
        }

        return month
    }


    func selectedDate(date: Date){

        if selectedDataOne == nil, selectedDataTwo == nil {
            selectedDataOne = date
        } else if let selectOne = selectedDataOne, selectedDataTwo == nil {

            if selectOne <= date {
                selectedDataTwo = date
            } else {
                selectedDataTwo = selectOne
                selectedDataOne = date
            }


        } else if selectedDataOne != nil, selectedDataTwo != nil {
            selectedDataOne = nil
            selectedDataTwo = nil
        }
    }
    
}
