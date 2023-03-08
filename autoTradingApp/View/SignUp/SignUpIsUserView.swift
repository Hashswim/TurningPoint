//
//  SignUpIsUserView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/05.
//

import UIKit

class SignUpIsUserView: UIView {

    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "대신증권\n고객이신가요?"
        label.textColor = .systemGray
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
