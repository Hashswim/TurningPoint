//
//  Constant.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/02/22.
//

import Foundation
import UIKit

struct Constant {
    var guideText = [NSMutableAttributedString]()

    let first = "너도 주식 할 수 있어 \n간단하게 터포 !"
    let second = "주식 !\n쉽고 빠른길로\n터포와 함께 지름길로"
    let third = "내 주식의 터닝포인트\n내 인생의 터닝포인트"
    let fourth = "터포와 함께라면\n주식, 일상 동시에\n챙길 수 있어"
    let fifth = "주식 더 이상 어렵지 않아요\n자동이니까"

    let fontSize = UIFont.boldSystemFont(ofSize: 30)

    lazy var attributedStr1 = NSMutableAttributedString(string: first)
    lazy var attributedStr2 = NSMutableAttributedString(string: second)
    lazy var attributedStr3 = NSMutableAttributedString(string: third )
    lazy var attributedStr4 = NSMutableAttributedString(string: fourth)
    lazy var attributedStr5 = NSMutableAttributedString(string: fifth )

    init() {
        setAttrivutedStr()
    }

    mutating func setAttrivutedStr() {
        attributedStr1.addAttribute(.font, value: fontSize, range: (first as NSString).range(of: "너도 주식 할 수 있어"))
        attributedStr2.addAttribute(.font, value: fontSize, range: (second as NSString).range(of: "주식 !"))
        attributedStr3.addAttribute(.font, value: fontSize, range: (third  as NSString).range(of: "내 주식"))
        attributedStr3.addAttribute(.font, value: fontSize, range: (third  as NSString).range(of: "내 인생"))
        attributedStr4.addAttribute(.font, value: fontSize, range: (fourth as NSString).range(of: "주식, 일상 동시에\n챙길 수 있어"))
        attributedStr5.addAttribute(.font, value: fontSize, range: (fifth  as NSString).range(of: "자동이니까"))

        guideText = [attributedStr1,
                     attributedStr2,
                     attributedStr3,
                     attributedStr4,
                     attributedStr5
        ]
    }


}
