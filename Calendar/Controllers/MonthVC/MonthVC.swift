//
//  MonthVC.swift
//  Calendar
//
//  Created by Hudihka on 02/02/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class MonthVC: UIViewController {

//    weak var delegate: ProtocolReloadDataTV?

    @IBOutlet weak var collectionView: UICollectionView!

    var month: [Month] = []

    let dataParser = DateParser.shared


    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.baseSettingsCV(obj: self,
                                           arrayNameCell: ["YearsDayCell"],
                                           arrayNameHeders: ["MonthHeader"])
        
         collectionView.contentInset = UIEdgeInsets(top: 0, left: offsetCV, bottom: 0, right: offsetCV)

    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !scrollInTooDay{
            return
        }

        if let section = self.month.firstIndex(where: {dataParser.monthInDayTooDay(date: $0.days)}), section != 0 {
            self.collectionView.layoutIfNeeded()

            let customSection = section - 1
            let days = month[customSection].days

            let index = IndexPath(row: days.count - 1, section: customSection)
            self.collectionView.scrollToItem(at: index, at: .top, animated: true)
            textHeder()
        } else if let date = month.first?.days.first{
            self.title = "\(date.year) г."
        }

        collectionView.reloadData()

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


        guard let date = month[indexPath.section].dateInIndex(index: indexPath),
            dataParser.dateInDiapason(date: date) else {return}

        dataParser.selectedDate(date: date)
        self.collectionView.reloadData()
        self.delegate?.reloadDataTV()

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


    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        textHeder()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                        withVelocity velocity: CGPoint,
                                        targetContentOffset: UnsafeMutablePointer<CGPoint>) {

        textHeder()

    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                           willDecelerate decelerate: Bool){
        textHeder()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        textHeder()
    }


   fileprivate func textHeder(){
        if let cell = self.collectionView.visibleCells.first as? YearsDayCell, let text = cell.day?.year {
            self.title = "\(text)"
        }
    }
}



