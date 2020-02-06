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

    var arrayDay: [Date] = []
    var offset: Int = 0


    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func setCollectionViewDataSourceDelegate<D: UICollectionViewDelegateFlowLayout & UICollectionViewDataSource>(_ dataSourceDelegate: D) {

        collectionView.registerCell(cellName: "YearsDayCell")

        collectionView.isUserInteractionEnabled = true

        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        collectionView.backgroundColor = UIColor.clear
        collectionView.setContentOffset(collectionView.contentOffset, animated: false)

        collectionView.allowsSelection = false
        //        collectionView.reloadData()
    }

    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }


    func desingCell(month: Month){

        labelMonth.text = month.nameMonth
        labelMonth.alpha = month.isDiapazone ? 1 : 0.3

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
                cell.day = nil
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
