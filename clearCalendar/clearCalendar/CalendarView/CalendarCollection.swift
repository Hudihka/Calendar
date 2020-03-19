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

    private let dataParser = DateParser.shared
    private var month: [Month] = []

    weak var delegateLabelTitle: LabelTitleText?

    init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(frame: frame, collectionViewLayout: layout)
		
		self.create()

    }
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
        self.create()
    }


	private func create(){
		month = DateParser.shared.arrayMonth

        self.delegate = self
        self.dataSource = self

        self.register(UINib(nibName: "YearsDayCell", bundle: nil), forCellWithReuseIdentifier: "YearsDayCell")
        self.register(UINib(nibName: "MonthHeader", bundle: nil),
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: "MonthHeader");


        translatesAutoresizingMaskIntoConstraints = false

        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = true
		
		self.backgroundColor = CConstants.bacground

        //скролл при старте

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

        if offset != 0, ind < offset {
            cell.day = nil
            return cell
        }

        cell.day = mon.days[ind - offset]
        cell.delegate = self

        return cell
    }


    //    //    size
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
		
		
	func collectionView(_ collectionView: UICollectionView, layout
						collectionViewLayout: UICollectionViewLayout,
						minimumLineSpacingForSectionAt section: Int) -> CGFloat {
			return 0
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0
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
        dataParser.selectedDate(date: date)
        self.reloadData()
    }
}
