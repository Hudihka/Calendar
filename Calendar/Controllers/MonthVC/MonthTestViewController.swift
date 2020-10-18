//
//  MonthTestViewController.swift
//  Calendar
//
//  Created by Hudihka on 18/10/2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class MonthTestViewController: UIViewController {
	
	private var collection: CollectionCalendar?

    override func viewDidLoad() {
        super.viewDidLoad()

        let dataParser = DateParser()
		dataParser.dateFrom = Date(day: 1, month: 10, year: 2020)
		dataParser.dateTo = Date(day: 31, month: 10, year: 2020)
		
		collection = CollectionCalendar(frame: CGRect(origin: .zero, size: self.view.frame.size),
										dataParser: dataParser)
		
		self.view.addSubview(collection!)
		
		collection?.blockTextHeader = {[weak self] text in
			self?.title = text
		}
		
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		collection?.scrollCollection()
	}
    

}
