//
//  SupportClass.swift
//  ginzaWindRegistration
//
//  Created by Hudihka on 15/01/2019.
//  Copyright © 2019 Username. All rights reserved.
//

import UIKit


let hDdevice = UIScreen.main.bounds.size.height
let wDdevice = UIScreen.main.bounds.size.width



//MARK: - Calendar

let scrollInTooDay = true
  
//Коллекшен вью с годами
let offsetCV: CGFloat   = 5
let offsetCell: CGFloat = 3

let widthMonth = (wDdevice - (2 * offsetCV) - (4 * offsetCell)) / 3
let widthDayInMonth = widthMonth / 7
let heightMonth = (widthDayInMonth * 6.5) + 30 //30 высота лейбла

//Коллекшен вью с месяцами

let widthWeek = wDdevice - (2 * offsetCV)
let widthDay  = widthWeek / 7

//


//MARK: - Colors


let colorDay = UIColor.black
let colorWekend = UIColor.red

let selectedView = UIColor.red.withAlphaComponent(0.3)

