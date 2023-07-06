//
//  HeaderView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/05.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let reuseIdentifier = "sticky-column-reuse-identifier"
    static let reuseElementKind = "sticky-column-element-kind"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

}
