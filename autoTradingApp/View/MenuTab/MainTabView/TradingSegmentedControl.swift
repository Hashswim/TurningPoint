//
//  mainTabSegmentedControl.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/12.
//

import UIKit

class TradingSegmentedControl: UISegmentedControl {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.removeBackgroundAndDivider()
    }
    override init(items: [Any]?) {
        super.init(items: items)
        self.removeBackgroundAndDivider()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func removeBackgroundAndDivider() {
//        let image = UIImage()
//        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
//        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
//        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)

//        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray, .font: NotoSansFont.bold(size: 17)], for: .normal)

        
    }

}
