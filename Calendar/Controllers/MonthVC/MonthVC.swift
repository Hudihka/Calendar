//
//  MonthVC.swift
//  Calendar
//
//  Created by Hudihka on 02/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class MonthVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var month: [MonthVC] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    static func route() -> MonthVC{
        
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let VC = stor.instantiateViewController(withIdentifier: "MonthVC") as! MonthVC
        
        return VC
    }
    


}


extension MonthVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

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
        return
    }


    //size

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: widthMonth, height: heightMonth)
    }


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

