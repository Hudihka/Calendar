//
//  SupportNotification.swift
//  GinzaGO
//
//  Created by Username on 31.01.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import UIKit


enum EnumNotification: String{

    case reloadPageVC           = "reloadPageVC"
    case rejectOrApproveTask    = "rejectOrApproveTask"  //принять отклонить заявку

    case newFiltersSelected     = "newFiltersSelected"   //выбрали новые фильтры и перезагружаем таблицу
    case playNewFilters         = "playNewFilters"       //загрузка данных с учетом фиильтров
    case playInternetStatus     = "playInternetStatus"   //запрос на бэк прии смене интернет статуса


    case reloadBlure            = "reloadBlure"          //подгрузка фильтров с бэка закончена, показываем шторку


    private var nameNotific: NSNotification.Name {
        return NSNotification.Name(self.rawValue)
    }

    func subscribeNotific(observer: Any, selector: Selector){
        NotificationCenter.default.addObserver(observer,
                                               selector: selector,
                                               name: self.nameNotific,
                                               object: nil)
    }

    func notific(){
        NotificationCenter.default.post(name: self.nameNotific, object: nil)
    }

    func notific(userInfo: [String: Any]) {
        NotificationCenter.default.post(name: self.nameNotific, object: nil, userInfo: userInfo)
    }


}



/*

 NotificationCenter.default.addObserver(self,
 selector: #selector(appExitBacground(notfication:)),
 name: UIApplication.willEnterForegroundNotification,
 object: nil)

 NotificationCenter.default.addObserver(self,
 selector: #selector(rebootGoogleMap),
 name: .rebootGoogleMap,
 object: nil)


 @objc func rebootGoogleMap(notfication: Notification) {}

 deinit {
 NotificationCenter.default.removeObserver(self)
 }

 */
