//
//  ExtraExtension.swift
//  clearCalendar
//
//  Created by Username on 10.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

//это те расширения что имеются по умолчанию

extension Date{
    //календарь

    func printDate(format: String = "d MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: self)
    }
}


extension UIView {
    func addRadius(number: CGFloat) {
        self.layer.cornerRadius = number
        self.layer.masksToBounds = true
    }
}


extension String {
    func getDatwToString(_ formater: String = "yyyy-MM-dd HH:mm:ssZ") -> Date? { //переобраз строку в дату
        //2019-06-07 07:56:17+00

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }
}


extension UICollectionView{

    func baseSettingsCV(obj: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource,
                        scrollEnabled: Bool = true,
                        clicableCell: Bool = true,
                        arrayNameCell: [String]?,
                        arrayNameHeders: [String]? = nil){

        self.delegate = obj
        self.dataSource = obj
        self.backgroundColor = UIColor.clear
        self.isScrollEnabled = scrollEnabled

        //  скорость с которой движУТся ячейки
        //  collectionView.decelerationRate = UIScrollView.DecelerationRate.fast

        self.allowsSelection = clicableCell

        arrayNameCell?.forEach({ (cellName) in
            self.registerCell(cellName: cellName)
        })

        arrayNameHeders?.forEach({ (header) in
            self.registerHeader(headerName: header)
        })
    }

    func registerCell(cellName: String){
        self.register(UINib(nibName: cellName, bundle: nil), forCellWithReuseIdentifier: cellName)
    }

    func registerHeader(headerName: String){
        self.register(UINib(nibName: headerName, bundle: nil),
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: headerName);
    }


}
