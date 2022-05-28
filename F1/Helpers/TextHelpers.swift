//
//  TextHelpers.swift
//  F1
//
//  Created by Francisco F on 5/15/22.
//

import Foundation
import UIKit

enum F1Fonts: String {
    case bold = "Formula1-Display-Bold"
    case regular = "Formula1-Display-Regular"
    case wide = "Formula1-Display-Wide"
}

class TextHelpers {
    public static func getBackPartFrom(date: String, part: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let convertedDate = dateFormatter.date(from: date)

        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = part
        let day = dateFormatter.string(from: convertedDate!)

        return day
    }
    
    public static func getPrettyTimeFrom(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        let convertedDate = dateFormatter.date(from: time)

        guard dateFormatter.date(from: time) != nil else {
            assert(false, "no date from string")
            return ""
        }

        dateFormatter.dateFormat = "h:mm a"
        let day = dateFormatter.string(from: convertedDate!)

        return day
    }
    
    public static func attributedTextFrom(fontName: String, fontColor: UIColor, fontSize: CGFloat, text: String) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: fontColor,
                          NSAttributedString.Key.font: UIFont(name: fontName, size: fontSize)]
        return NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
