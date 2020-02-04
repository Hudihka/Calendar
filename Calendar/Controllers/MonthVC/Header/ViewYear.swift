//
//  ViewYear.swift
//  Calendar
//
//  Created by Username on 04.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class ViewYear: UIView {
    @IBOutlet var counteinerView: UIView!
    @IBOutlet weak var labelYear: UILabel!


    var day: Day? {
        didSet{
            if let day = day {
                self.labelYear.text = "\(day.date.year) г."
            }
        }
    }

    override init (frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        settingsView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        xibSetup()
        settingsView()
    }

    private func xibSetup() {
        counteinerView = loadViewFromNib("ViewYear")
        counteinerView.frame = bounds
        counteinerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(counteinerView )
    }

    private func settingsView() {

        counteinerView.backgroundColor = UIColor.white
    }


    deinit {
        NotificationCenter.default.removeObserver(self)
    }


}
