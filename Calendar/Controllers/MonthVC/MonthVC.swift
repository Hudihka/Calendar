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
    
    var month: [Month] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.baseSettingsCV(obj: self,
                                           arrayNameCell: ["YearsDayCell"],
                                           arrayNameHeders: ["MonthHeader"])
        
    }
    
    static func route(month: [Month]) -> MonthVC{
        
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let VC = stor.instantiateViewController(withIdentifier: "MonthVC") as! MonthVC
        
        VC.month = month
        
        return VC
    }
    


}


extension MonthVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return month.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let mon = month[section]
        return mon.days.count + mon.offset
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearsDayCell", for: indexPath) as! YearsDayCell

        let ind = indexPath.row
        let mon = month[indexPath.section]
        let offset = mon.offset

        if offset != 0, ind < offset {
            cell.day = nil
            return cell
        }

        cell.day = mon.days[ind - offset]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }


//    size

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: widthDay, height: widthDay)
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

        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MonthHeader", for: indexPath) as! MonthHeader
        view.month = month[indexPath.section]
        return view

    }

}

