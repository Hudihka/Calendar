//
//  CalendarCollection.swift
//  clearCalendar
//
//  Created by Username on 10.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

protocol LabelTitleText: class {
    func reloadText(text: String)
}



class CalendarCollection: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	fileprivate var dateParser: DateParser?
	
	private var month: [Month] = []

    weak var delegateLabelTitle: LabelTitleText?

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: layout)
		
		self.create(layout: layout)
		
    }
	
	required init?(coder aDecoder: NSCoder) {
		
		super.init(coder: aDecoder)
		
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .vertical
		
		self.collectionViewLayout = layout
		
		self.create(frame: false, layout: layout)
	
    }


	private func create(frame: Bool = true, layout: UICollectionViewFlowLayout){
		
		translatesAutoresizingMaskIntoConstraints = !frame
		
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
		
		
		self.delegate = self
		self.dataSource = self
		
		self.register(UINib(nibName: "YearsDayCell", bundle: nil), forCellWithReuseIdentifier: "YearsDayCell")
		self.register(UINib(nibName: "MonthHeader", bundle: nil),
					  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
					  withReuseIdentifier: "MonthHeader");
		
		
		showsHorizontalScrollIndicator = false
		showsVerticalScrollIndicator = true
		
		self.backgroundColor = CConstants.bacground
		
	}
	
	func startCollection(from: Date?, to: Date?){
		
		dateParser = DateParser(from: from, to: to)
		month = dateParser!.arrayMonth
		
		self.reloadData()
		
		guard let dataParser = self.dateParser else {return}
		

		if let section = self.month.firstIndex(where: {dataParser.monthInDayTooDay(date: $0.days)}), section != 0 {
			self.layoutIfNeeded()

			let customSection = section - 1
			let days = month[customSection].days

			let index = IndexPath(row: days.count - 1, section: customSection)
			self.scrollToItem(at: index, at: .top, animated: true)

			textHeder()
		} else if let date = month.first?.days.first{
			self.delegateLabelTitle?.reloadText(text: "\(date.year) г.")
		}
		
		
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
		
		cell.parser = self.dateParser

        if offset != 0, ind < offset {
            cell.day = nil
            return cell
        }

        cell.day = mon.days[ind - offset]
        cell.delegate = self

        return cell
    }


    //size
    //
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let widthDay = (collectionView.frame.width / 7)

        return CGSize(width: widthDay, height: widthDay)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.frame.size.width, height: 100)
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

    func textHeder(){
        if let cell = self.visibleCells.first, let indexSection = self.indexPath(for: cell)?.section, let date = month[indexSection].days.first {
            self.delegateLabelTitle?.reloadText(text: "\(date.year) г.")
        }
    }

}

extension CalendarCollection: SelectedDateCell {
	func selectedDate(_ date: Date){
		if let dateParser = dateParser {
			dateParser.selectedDate(date: date)
			self.reloadData()
		}
	}
}
