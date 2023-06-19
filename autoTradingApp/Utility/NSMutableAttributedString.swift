//
//  NSMutableAttributedString.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/06/12.
//

import UIKit

extension NSMutableAttributedString {

    func bold(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font =  NotoSansFont.bold(size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func regular(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = NotoSansFont.regular(size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }

    func medium(string: String, fontSize: CGFloat) -> NSMutableAttributedString {
        let font = NotoSansFont.medium(size: fontSize)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        self.append(NSAttributedString(string: string, attributes: attributes))
        return self
    }
}
