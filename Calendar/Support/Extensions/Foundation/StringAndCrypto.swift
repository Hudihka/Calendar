//
//  String.swift
//  GinzaGO
//
//  Created by Username on 19.08.2019.
//  Copyright © 2019 ITMegastar. All rights reserved.
//

import Foundation
import CommonCrypto
import UIKit

func randomString(WithLength len: Int) -> String {
    let letters: NSString = "abcdefABCDEF123456789"

    let randomString: NSMutableString = NSMutableString(capacity: len)

    for _ in 0 ..< len {
        let length = UInt32 (letters.length)
        let rand = arc4random_uniform(length)
        randomString.appendFormat("%C", letters.character(at: Int(rand)))
    }

    return randomString as String
}

extension NSMutableAttributedString {   //делает часть строки другим цветом

    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }

    public func setAsLink(textToFind: String, linkURL: String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}

extension String {


    func getDatwToString(_ formater: String = "yyyy-MM-dd HH:mm:ssZ") -> Date? { //переобраз строку в дату
        //2019-06-07 07:56:17+00

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formater

        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) // replace Date String
    }

    var dateStringRemoveT: String {
        if let dayDate = self.components(separatedBy: "T").first {
            let arrayStr = dayDate.components(separatedBy: "-")
            if arrayStr.count == 3 {

            return "\(arrayStr[2]).\(arrayStr[1]).\(arrayStr[0])"
            }
        }
        return "-"
    }



    func deleteSumbol(sumbol: String) -> String {
        var str = ""
        self.components(separatedBy: sumbol).forEach { (obj) in
            str += obj
        }

        return str
    }

    var textEditor: String? { //удаляе с конца строки пробелы
        var text = self
        while text.last == "\n" || text.last == " " {
            if !text.isEmpty {
                text.removeLast()
            }
        }

        return text == "" ? nil : text
    }

//удаление с конца removeCount символов
    mutating func removeCharsFromEnd(removeCount :Int) -> String{
        var myStr = self
        myStr = (myStr as NSString).substring(to: (myStr as NSString).length - removeCount)
        return String(myStr)
    }

}

extension Range where Bound == String.Index {
    init (from: Int, to: Int) {
        self.init(uncheckedBounds: (String.Index(encodedOffset: from), String.Index(encodedOffset: to)))
    }
}
