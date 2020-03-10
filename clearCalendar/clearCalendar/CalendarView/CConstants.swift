//
//  CConstant.swift
//  clearCalendar
//
//  Created by Username on 10.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

struct CConstants {

    //CALENDAR

    static var selectedView          = UIColor.green
    static var selectedViewExtreme   = UIColor(red: 94/255, green: 129/255, blue: 93/255, alpha: 1)

    static var weekdays              = UIColor.white
    static var weekdaysNoDiapasone   = UIColor(red: 196/255, green: 196/255, blue: 196/255, alpha: 1)

    static var wekend                = UIColor.red
    static var wekendNoDiapasone     = UIColor(red: 172/255, green: 101/255, blue: 101/255, alpha: 1)

    static var textColorHeader       = UIColor.black

    static var cirkle                = UIColor.yellow

    static var selectedDate          = true

    // если dateFrom или dateTo нил то создаются свои даты +- 50 дней от сегодняшнего дня

    static var countSeconds: Double = 50*24*3600

}
