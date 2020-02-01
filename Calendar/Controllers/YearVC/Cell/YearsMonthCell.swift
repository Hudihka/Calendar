//
//  YearsMonthCell.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class YearsMonthCell: UICollectionViewCell {

    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    var arrayDay: [Day] = []
    var offset: Int = 0


    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.baseSettingsCV(obj: self,
                                      scrollEnabled: false,
                                      clicableCell: false,
                                      arrayNameCell: ["YearsDayCell"])

    }

    func desingCell(month: Month){

        let text = month.nameMonth
        labelMonth.text = text

        arrayDay = month.days
        offset = month.offset

        collectionView.reloadData()
    }

}

extension YearsMonthCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayDay.count + offset
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearsDayCell", for: indexPath) as! YearsDayCell

        let ind = indexPath.row

        if offset != 0, ind < offset {
            return cell
        }

        cell.day = arrayDay[ind - offset]

        return cell
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: widthDayInMonth, height: widthDayInMonth)
    }

    //    func collectionView(_ collectionView: UICollectionView,
    //                        layout collectionViewLayout: UICollectionViewLayout,
    //                        insetForSectionAt section: Int) -> UIEdgeInsets {
    //
    //        return UIEdgeInsets(top: 0, left: offsetCV, bottom: 0, right: offsetCV)
    //    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
}
