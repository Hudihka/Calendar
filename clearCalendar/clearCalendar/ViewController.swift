//
//  ViewController.swift
//  clearCalendar
//
//  Created by Username on 10.03.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()


        //DateParser.shared.dateSettings(from: Date?, to: Date?)

        let frame = CGRect(x: 0, y: 100, width: 414, height: 636)
        let collection = CalendarCollection(frame: frame)
        collection.delegateLabelTitle = self
        self.view.addSubview(collection)
		collection.startCollection(from: nil, to: nil)

    }

}


extension ViewController: LabelTitleText {
    func reloadText(text: String) {
        labelTitle.text = text
    }
}
