//
//  DateParser.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 Hudihka. All rights reserved.
//

import UIKit

class DateParser {

    static let shared = DateParser()


    //это начальная и конечная дата для календаря

    private var dateFrom: Date? = nil
    private var dateTo: Date? = nil

    func dateSettings(from: Date?, to: Date?){
        self.dateFrom = from
        self.dateTo = to
    }

    func clearDateSettings(){
        self.dateFrom = nil
        self.dateTo = nil
    }

    /*
     если для селектДата1 есть значение а селектДата2 нет
     то дата 1 является конечной

     если есть селектДата1 и селектДата2 эти значения и пользаватель нажимает еще раз
     эти оба значения сбрасываютя

     */

    private var selectedDataOne: Date? = nil
    private var selectedDataTwo: Date? = nil

    func getSelectedDate(_ one: Bool) -> Date?{
        return one ? self.selectedDataOne : self.selectedDataTwo
    }

    func clearSelectedDate(){
        self.selectedDataOne = nil
        self.selectedDataTwo = nil
    }

    
    var customFrom: Date {
        return dateFrom ?? Date(timeInterval: -1 * (CConstants.countSeconds), since: Date())
    }
    
    var customTo: Date {
        return dateTo ?? Date(timeInterval: CConstants.countSeconds, since: Date())
    }


    func dateInDiapason(date: Date?) -> Bool {
        guard let date = date else {
            return false
        }

        if customFrom <= date, date <= customTo {
            return true
        }

        return false
    }

    //есть хотя бы один день месяца в диапазоне dateFrom - dateTo

    func monthInDiapason(date: [Date]) -> Bool {
        if let _ = date.first(where: {self.dateInDiapason(date: $0)}){
            return true
        }

        return false
    }

    //есть ли в месяце день что идет сейчас

    func monthInDayTooDay(date: [Date]) -> Bool {

        if date.firstIndex(where: {$0.isTooDay}) != nil {
            return true
        }

        return false
    }


    var arrayMonth: [Month] {

        if customFrom > customTo {
            return []
        }

        let calendar = Calendar.current
        var months: [Month] = []

        for i in customFrom.year...customTo.year{
            for mon in 1...12 {
                if let dateMonth = DateComponents(calendar: calendar, year: i, month: mon).date, dateMonth <= customTo {
                    let month = Month(date: dateMonth, year: i, numberMonth: mon)
                    months.append(month)
                }
            }
        }

        return months
    }


    //MARK: - SELECTED


    func dateInDiapasonSelected(date: Date) -> Bool {
        guard let selectedDataOne = selectedDataOne,
            let selectedDataTwo = selectedDataTwo else {
                return false
        }


        if selectedDataOne < date, date < selectedDataTwo {
            return true
        }

        return false
    }


    private func dateSelectedSettings(one: Date?, two: Date?){

        self.selectedDataOne = one
        self.selectedDataTwo = CConstants.multiselect ? two : one
    }

    func selectedDate(date: Date){

        if selectedDataOne == nil, selectedDataTwo == nil {
            self.dateSelectedSettings(one: date, two: nil)
        } else if let selectOne = selectedDataOne, selectedDataTwo == nil {

            if selectOne <= date {
                selectedDataTwo = date
            } else {
                self.dateSelectedSettings(one: date, two: selectOne)
            }

        } else if selectedDataOne != nil, selectedDataTwo != nil {
            clearSelectedDate()
        }
    }
    
}
