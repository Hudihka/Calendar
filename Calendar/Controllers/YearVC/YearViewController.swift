//
//  YearViewController.swift
//  Calendar
//
//  Created by Username on 31.01.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit
import Foundation

class YearViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    let years = DateParser.shared.arrayYears

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.baseSettingsCV(obj: self,
                                           arrayNameCell: ["YearsMonthCell"],
                                           arrayNameHeders: ["HeaderCollection"])
    }


}

extension YearViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return years.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearsMonthCell", for: indexPath) as! YearsMonthCell

        let month = years[indexPath.section].months[indexPath.row]

        cell.desingCell(month: month)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }


    //size

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: widthMonth, height: heightMonth)
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

        return offsetCell
    }

    //MARK: - Header

    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollection", for: indexPath) as! HeaderCollection
        view.year = years[indexPath.section]
        return view

    }

}
