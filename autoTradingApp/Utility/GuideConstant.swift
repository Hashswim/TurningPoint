//
//  Constant.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/02/22.
//

import Foundation
import UIKit

struct GuideConstant {
    static var guideText = [NSMutableAttributedString]()
    static var tradingButtonText = [NSMutableAttributedString]()

    let first = "주식 자동매매를 함께할\n수익 알고리즘을 선택 할 수 있어요"
    let second = "매매 시그널 알림으로 내 주식\n최적의 거래 타이밍을 찾아보세요"
    let third = "복잡한 주식화면은 이제 안녕!\n터닝포인트와 함께 시작해볼까요?"

    let sixth = "Trading"
    let seventh = "Off"
    let eighth = "On"


    let LargeFont = NotoSansFont.bold(size: 17)
    let RegularFont = NotoSansFont.regular(size: 17)

    lazy var attributedStr1 = NSMutableAttributedString(string: first)
    lazy var attributedStr2 = NSMutableAttributedString(string: second)
    lazy var attributedStr3 = NSMutableAttributedString(string: third )

    lazy var attributedStr6 = NSMutableAttributedString(string: sixth )
    lazy var attributedStr7 = NSMutableAttributedString(string: seventh )
    lazy var attributedStr8 = NSMutableAttributedString(string: eighth )


    init() {
        setAttrivutedStr()
    }

    mutating func setAttrivutedStr() {
        attributedStr1.addAttribute(.font, value: RegularFont, range: (first as NSString).range(of: "주식 자동매매를 함께할"))
        attributedStr1.addAttribute(.foregroundColor, value: UIColor.white, range: (first as NSString).range(of: "주식 자동매매를 함께할"))

        attributedStr1.addAttribute(.font, value: LargeFont, range: (first as NSString).range(of: "수익 알고리즘을 선택 할 수 있어요"))
        attributedStr1.addAttribute(.foregroundColor, value: UIColor.white, range: (first as NSString).range(of: "수익 알고리즘을 선택 할 수 있어요"))

        attributedStr2.addAttribute(.font, value: RegularFont, range: (second as NSString).range(of: "매매 시그널 알림으로 내 주식"))
        attributedStr2.addAttribute(.foregroundColor, value: UIColor.white, range: (second as NSString).range(of: "매매 시그널 알림으로 내 주식"))

        attributedStr2.addAttribute(.font, value: LargeFont, range: (second as NSString).range(of: "최적의 거래 타이밍을 찾아보세요"))
        attributedStr2.addAttribute(.foregroundColor, value: UIColor.white, range: (second as NSString).range(of: "최적의 거래 타이밍을 찾아보세요"))

        attributedStr3.addAttribute(.font, value: RegularFont, range: (third  as NSString).range(of: "복잡한 주식화면은 이제 안녕!"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "복잡한 주식화면은 이제 안녕!"))

        attributedStr3.addAttribute(.font, value: LargeFont, range: (third  as NSString).range(of: "터닝포인트와 함께 시작해볼까요?"))
        attributedStr3.addAttribute(.foregroundColor, value: UIColor.white, range: (third  as NSString).range(of: "터닝포인트와 함께 시작해볼까요?"))


        GuideConstant.guideText = [attributedStr1,
                     attributedStr2,
                     attributedStr3
        ]

        attributedStr6.addAttribute(.font, value: RegularFont, range: (sixth  as NSString).range(of: "Trading"))
        attributedStr6.addAttribute(.foregroundColor, value: MySpecialColors.borderGray2, range: (sixth  as NSString).range(of: "Trading"))

        attributedStr7.addAttribute(.font, value: LargeFont, range: (sixth  as NSString).range(of: "Off"))
        attributedStr7.addAttribute(.foregroundColor, value: UIColor.white, range: (sixth  as NSString).range(of: "Off"))

        attributedStr8.addAttribute(.font, value: LargeFont, range: (seventh  as NSString).range(of: "On"))
        attributedStr8.addAttribute(.foregroundColor, value: UIColor.white, range: (seventh  as NSString).range(of: "On"))

        GuideConstant.tradingButtonText = [attributedStr6,
                             attributedStr7,
                             attributedStr8]
    }


}
