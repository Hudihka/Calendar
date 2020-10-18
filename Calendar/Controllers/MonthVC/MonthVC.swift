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

    var dataParser = DateParser()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataParser.dateFrom = Date(day: 1, month: 2, year: 2019)
        dataParser.dateTo = Date(day: 10, month: 6, year: 2021)
        
        month = dataParser.arrayMonth

        settingsCV()

    }
	
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		scrollCollection()
	}
	
	
	private func scrollCollection(){

        if ConstantCalendar.scrollInTooDay == false {
            return
        }

		if let section = self.month.firstIndex(where: {$0.isConteinsToday}), section != 0 {
			//скроллим к хедеру
			
			if let attributes = collectionView.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader,
																					   at: IndexPath(item: 0, section: section)) {
				var offsetY = attributes.frame.origin.y - collectionView.contentInset.top
				offsetY -= collectionView.safeAreaInsets.top
				collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
			}
			
			
			textHeder()
        }
		
	}



    
    static func route(month: [Month]) -> MonthVC{
        
        let stor = UIStoryboard(name: "Main", bundle: nil)
        let VC = stor.instantiateViewController(withIdentifier: "MonthVC") as! MonthVC
        
        VC.month = month
        
        return VC
    }



}


extension MonthVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
	
	fileprivate func settingsCV(){
		
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear

		collectionView.registerCell(cellName: "YearsDayCell")
		collectionView.registerHeader(headerName: "MonthHeader")
		
		collectionView.contentInset = UIEdgeInsets(top: 0,
												   left: ConstantCalendar.offsetCV,
												   bottom: 0,
												   right: ConstantCalendar.offsetCV)
        
	}

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

        if offset != 0, ind < offset { //пустая ячейка
            cell.day = nil
            return cell
        }

        cell.day = mon.days[ind - offset]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {


		guard ConstantCalendar.enableDay, 
			let date = month[indexPath.section].dateInIndex(index: indexPath),
            dataParser.dateInDiapason(date: date) else {return}

        dataParser.selectedDate(date: date)
        self.collectionView.reloadData()

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let collectionViewCell = cell as? YearsDayCell else {
            return
        }
        
        collectionViewCell.parser = self.dataParser
    }


//    size

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
		let widt = (collectionView.frame.size.width - (2 * ConstantCalendar.offsetCV))/7
        
        return CGSize(width: widt, height: widt)
    }


    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return ConstantCalendar.offsetCell
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



