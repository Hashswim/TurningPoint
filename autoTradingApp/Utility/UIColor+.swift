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
}
