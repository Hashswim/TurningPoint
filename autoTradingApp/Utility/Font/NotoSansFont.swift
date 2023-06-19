//
//  NotoSansFont.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/17.
//

import UIKit

enum NotoSansFont: String {
    case Bold = "NotoSansKR-Bold"
    case Regular = "NotoSansKR-Regular"
    case Medium = "NotoSansKR-Medium"

    func of(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size)!
    }

    static func bold(size: CGFloat) -> UIFont {
        return NotoSansFont.Bold.of(size: size)
    }

    static func regular(size: CGFloat) -> UIFont {
        return NotoSansFont.Regular.of(size: size)
    }

    static func medium(size: CGFloat) -> UIFont {
        return NotoSansFont.Medium.of(size: size)
    }
}
