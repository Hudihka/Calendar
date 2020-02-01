//
//  HeaderCollection.swift
//  Calendar
//
//  Created by Username on 01.02.2020.
//  Copyright © 2020 itMegastar. All rights reserved.
//

import UIKit

class HeaderCollection: UICollectionReusableView {

    @IBOutlet var labelYear: UILabel!

    var year: Year? {
        didSet{
            let text = year?.numberYear ?? Date().year
            labelYear.text = "\(text)"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
