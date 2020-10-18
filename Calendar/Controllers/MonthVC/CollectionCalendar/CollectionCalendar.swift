//
//  CollectionCalendar.swift
//  Calendar
//
//  Created by Hudihka on 18/10/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import Foundation
import UIKit

class CollectionCalendar: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
	
	var blockTextHeader : (String) -> () = { _ in }
	
	private var month: [Month] = []
	
	private var dataParser = DateParser()
	
	init(frame: CGRect, dataParser: DateParser) {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		super.init(frame: frame, collectionViewLayout: layout)
		
		self.dataParser = dataParser
		self.month = dataParser.arrayMonth
		
		self.delegate = self
		self.dataSource = self
		self.backgroundColor = UIColor.clear
		
		self.registerCell(cellName: "YearsDayCell")
		self.registerHeader(headerName: "MonthHeader")
		
		self.contentInset = UIEdgeInsets(top: 0, left: ConstantCalendar.offsetCV, bottom: 0, right: ConstantCalendar.offsetCV)
		
		self.showsVerticalScrollIndicator = false
		self.showsHorizontalScrollIndicator = false
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	func scrollCollection(){
		
		if ConstantCalendar.scrollInTooDay == false {
			return
		}
		
		if let section = self.month.firstIndex(where: {$0.isConteinsToday}), section != 0 {
			//скроллим к хедеру
			
			if let attributes = self.layoutAttributesForSupplementaryElement(ofKind: UICollectionView.elementKindSectionHeader,
																			 at: IndexPath(item: 0, section: section)) {
				var offsetY = attributes.frame.origin.y - self.contentInset.top
				offsetY -= self.safeAreaInsets.top
				self.setContentOffset(CGPoint(x: 0, y: offsetY), animated: ConstantCalendar.aniateScroll)
			}
			
			
			textHeder()
		}
		
	}
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return month.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		let mon = month[section]
		return mon.days.count + mon.offset
	}
	
	//MARK: - Cells
	
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
		
		if ConstantCalendar.enableDay == false {
			return
		}
		
		guard ConstantCalendar.enableDay,
			let date = month[indexPath.section].dateInIndex(index: indexPath),
			dataParser.dateInDiapason(date: date) else {return}
		
		dataParser.selectedDate(date: date)
		self.reloadData()
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		guard let collectionViewCell = cell as? YearsDayCell else {
			return
		}
		
		collectionViewCell.parser = self.dataParser
	}
	
	
	//MARK: - SIZE
	
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
	
	//MARK: - SCROLL
	
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
		if let cell = self.visibleCells.first as? YearsDayCell, let text = cell.day?.year {
			blockTextHeader("\(text)")
		}
	}
	
}

/*

UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var cells = [SushiModel]()

     init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        
        backgroundColor = #colorLiteral(red: 0.9589126706, green: 0.9690223336, blue: 0.9815708995, alpha: 1)
        delegate = self
        dataSource = self
        register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
        
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = Constants.galleryMinimumLineSpacing
        contentInset = UIEdgeInsets(top: 0, left: Constants.leftDistanceToView, bottom: 0, right: Constants.rightDistanceToView)
        
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    func set(cells: [SushiModel]) {
        self.cells = cells
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
        cell.mainImageView.image = cells[indexPath.row].mainImage
        cell.nameLabel.text = cells[indexPath.row].sushiName
        cell.smallDescriptionLabel.text = cells[indexPath.row].smallDescription
        cell.costLabel.text = "$\(cells[indexPath.row].cost)"
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.galleryItemWidth, height: frame.height * 0.8)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
*/
