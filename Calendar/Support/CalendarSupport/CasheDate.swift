//
//  CasheDate.swift
//  Calendar
//
//  Created by Username on 06.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation


class CasheDate {

    static let shared = CasheDate()

    private let dateCache = NSCache<NSString, Month>()

    func saveInCasehe(){
        DispatchQueue.global(qos: .userInteractive).async {
            DateParser.shared.arrayYears.forEach { (year) in
                for i in 1...12{
                    if self.getMonth(year: year.numberYear, month: i) == nil {
                        self.createMonth(year: year.numberYear, monthInt: i)
                    }
                }
            }
        }
    }


   @discardableResult func createMonth(year: Int, monthInt: Int) -> Month {
        let dateMonth = DateComponents(calendar: Calendar.current, year: year, month: monthInt).date!
        let month = Month(date: dateMonth, year: year, numberMonth: monthInt)

        saveMotnth(month, year: year, monthInt: monthInt)

        return month
    }

    private func generateKey(year: Int, month: Int) -> NSString {
        return "keyMonth: \(year) - \(month)" as NSString
    }


    private func saveMotnth(_ month: Month, year: Int, monthInt: Int){
        let key = generateKey(year: year, month: monthInt)
        dateCache.setObject(month, forKey: key)
    }

    func getMonth(year: Int, month: Int) -> Month?{
        let key = generateKey(year: year, month: month)

        if dateCache.object(forKey: key) != nil {
            print("---------------------------")
        }
        return dateCache.object(forKey: key)
    }


}
