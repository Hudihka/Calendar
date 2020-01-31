//
//  Date.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation

extension Date {

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

//    var year: UInt? {
//        let str = self.printDate(format: "yyyy")
//        return UInt(str)
//    }
//
//    var day: UInt? {
//        let str = self.printDate(format: "d")
//        return UInt(str)
//    }
//
//    var monthString: String{
//        return self.printDate(format: "MMMM")
//    }


}
