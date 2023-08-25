//
//  UIColor+.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/17.
//

import UIKit

extension UIColor {

    convenience init(hex: String) {

        var hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }

        guard hex.count == 6 else {
            self.init(cgColor: UIColor.gray.cgColor)
            return
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)

        self.init(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255,
            alpha: 1
        )
    }
}

enum MySpecialColors {
    static let red        = UIColor(hex: "#DA4167")
    static let green      = UIColor(hex: "#81E979")
    static let blue       = UIColor(hex: "#2B3A67")
    static let yellow     = UIColor(hex: "#FFFD82")
    static let purple     = UIColor(hex: "#3D315B")
    static let bgColor    = UIColor(hex: "#333743")
    static let tabBarTint = UIColor(hex: "#F65036")
    static let gray       = UIColor(hex: "#BFBFBF")
    static let darkGray   = UIColor(hex: "#272A35")
    static let textGray   = UIColor(hex: "#C4C4C4")
    static let cellGray   = UIColor(hex: "#2B2F3B")
    static let lightRed   = UIColor(hex: "#FF6A53")
    static let lightBlue  = UIColor(hex: "#7896FF")
    static let dropGray   = UIColor(hex: "#D9D9D9")
    static let lineGray   = UIColor(hex: "#A0A0A0")
    static let detailRed  = UIColor(hex: "#dd897e")
    static let detailBlue = UIColor(hex: "#7896ff")

    static let lightRed2   = UIColor(red: 255/255, green: 106/255, blue: 83/255, alpha: 0.6)
    static let traidingCircle = UIColor(red: 246/255, green: 80/255, blue: 54/255, alpha: 0.8)
    static let traidingCircle2 = UIColor(hex: "#40444F")

    static let lightBlue2  = UIColor(red: 117/255, green: 144/255, blue: 238/255, alpha: 0.6)

    static let textGray2 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.7)

    static let bgGray = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.15)
    static let borderGray = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.2)
    static let holderGray = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.3)
    static let borderGray2 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.6)
    static let borderGray3 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.4)

}
