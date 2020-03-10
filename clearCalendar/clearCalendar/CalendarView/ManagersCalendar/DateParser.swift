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

    func dateSelectedSettings(one: Date?, two: Date?){
        self.selectedDataOne = one
        self.selectedDataTwo = two
    }

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

    //нужны для строительства коллекции календаря

    private var arrayYears: [Year] {

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
