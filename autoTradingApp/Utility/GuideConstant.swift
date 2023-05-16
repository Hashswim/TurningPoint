//
//  Constant.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/02/22.
//

import Foundation
import UIKit

struct GuideConstant {
    var guideText = [NSMutableAttributedString]()
    var tradingButtonText = [NSMutableAttributedString]()

    let first = "너도 주식 할 수 있어 \n간단하게 터포 !"
    let second = "주식 !\n쉽고 빠른길로\n터포와 함께 지름길로"
    let third = "내 주식의 터닝포인트\n내 인생의 터닝포인트!"
    let fourth = "터포와 함께라면\n주식, 일상 동시에\n챙길 수 있어"
    let fifth = "주식 더 이상 어렵지 않아요\n자동이니까"

    let sixth = "Trading\nOff"
    let seventh = "Trading\nOn"

    let LargeFont = NotoSansFont.bold(size: 35)
    let RegularFont = NotoSansFont.regular(size: 20)
    let RegularFont2 = NotoSansFont.regular(size: 35)


    lazy var attributedStr1 = NSMutableAttributedString(string: first)
    lazy var attributedStr2 = NSMutableAttributedString(string: second)
    lazy var attributedStr3 = NSMutableAttributedString(string: third )
    lazy var attributedStr4 = NSMutableAttributedString(string: fourth)
    lazy var attributedStr5 = NSMutableAttributedString(string: fifth )

    lazy var attributedStr6 = NSMutableAttributedString(string: sixth )
    lazy var attributedStr7 = NSMutableAttributedString(string: seventh )

    init() {
        setAttrivutedStr()
    }

    mutating func setAttrivutedStr() {
        attributedStr1.addAttribute(.font, value: LargeFont, range: (first as NSString).range(of: "너도 주식 할 수 있어"))
        attributedStr1.addAttribute(.foregroundColor, value: UIColor.white, range: (first as NSString).range(of: "너도 주식 할 수 있어"))

        attributedStr1.addAttribute(.font, value: RegularFont, range: (first as NSString).range(of: "간단하게 터포 !"))
        attributedStr1.addAttribute(.foregroundColor, value: UIColor.white, range: (first as NSString).range(of: "간단하게 터포 !"))

        attributedStr2.addAttribute(.font, value: LargeFont, range: (second as NSString).range(of: "주식 !"))
        attributedStr2.addAttribute(.foregroundColor, value: UIColor.white, range: (second as NSString).range(of: "주식 !"))

        attributedStr2.addAttribute(.font, value: RegularFont, range: (second as NSString).range(of: "쉽고 빠른길로\n터포와 함께 지름길로"))
        attributedStr2.addAttribute(.foregroundColor, value: UIColor.white, range: (second as NSString).range(of: "쉽고 빠른길로\n터포와 함께 지름길로"))


        attributedStr3.addAttribute(.font, value: LargeFont, range: (third  as NSString).range(of: "내 주식"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "내 주식"))

        attributedStr3.addAttribute(.font, value: RegularFont, range: (third  as NSString).range(of: "의 터닝포인트"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "의 터닝포인트"))


        attributedStr3.addAttribute(.font, value: LargeFont, range: (third  as NSString).range(of: "내 인생"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "내 인생"))

        attributedStr3.addAttribute(.font, value: RegularFont2, range: (third  as NSString).range(of: "의 터닝포인트"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "의 터닝포인트"))

        attributedStr3.addAttribute(.font, value: RegularFont2, range: (third  as NSString).range(of: "의 터닝포인트!"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "의 터닝포인트!"))

        attributedStr4.addAttribute(.font, value: RegularFont, range: (fourth as NSString).range(of: "터포와 함께라면"))
        attributedStr4.addAttribute(.foregroundColor, value: UIColor.white, range: (fourth as NSString).range(of: "터포와 함께라면"))

        attributedStr4.addAttribute(.font, value: LargeFont, range: (fourth as NSString).range(of: "주식, 일상 동시에\n챙길 수 있어"))
        attributedStr4.addAttribute(.foregroundColor, value: UIColor.white, range: (fourth as NSString).range(of: "주식, 일상 동시에\n챙길 수 있어"))


        attributedStr5.addAttribute(.font, value: RegularFont, range: (fifth  as NSString).range(of: "주식 더 이상 어렵지 않아요"))
        attributedStr5.addAttribute(.foregroundColor, value: UIColor.white, range: (fifth  as NSString).range(of: "주식 더 이상 어렵지 않아요"))

        attributedStr5.addAttribute(.font, value: LargeFont, range: (fifth  as NSString).range(of: "자동이니까"))
        attributedStr5.addAttribute(.foregroundColor, value: UIColor.white, range: (fifth  as NSString).range(of: "자동이니까"))


        guideText = [attributedStr1,
                     attributedStr2,
                     attributedStr3,
                     attributedStr4,
                     attributedStr5
        ]

        attributedStr6.addAttribute(.font, value: RegularFont, range: (sixth  as NSString).range(of: "Trading"))
        attributedStr6.addAttribute(.foregroundColor, value: UIColor.white, range: (sixth  as NSString).range(of: "Trading"))

        attributedStr6.addAttribute(.font, value: LargeFont, range: (sixth  as NSString).range(of: "Off"))
        attributedStr6.addAttribute(.foregroundColor, value: UIColor.white, range: (sixth  as NSString).range(of: "Off"))

        attributedStr7.addAttribute(.font, value: RegularFont, range: (seventh  as NSString).range(of: "Trading"))
        attributedStr7.addAttribute(.foregroundColor, value: UIColor.white, range: (seventh  as NSString).range(of: "Trading"))

        attributedStr7.addAttribute(.font, value: LargeFont, range: (seventh  as NSString).range(of: "On"))
        attributedStr7.addAttribute(.foregroundColor, value: UIColor.white, range: (seventh  as NSString).range(of: "On"))

        tradingButtonText = [attributedStr6,
                             attributedStr7]
    }


}
