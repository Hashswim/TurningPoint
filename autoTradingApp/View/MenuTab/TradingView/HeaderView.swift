//
//  HeaderView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/05.
//

import UIKit

class HeaderView: UICollectionReusableView {

    static let reuseIdentifier = "sticky-header-reuse-identifier"
    static let reuseElementKind = "sticky-header-element-kind"

    lazy var label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .blue
        
        addSubview(label)

        label.text = "ddkdsjfjsdfksadfhskdlfhl"
        label.textColor = .white
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }

    func configureLayout() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            //            label.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])

        for index in 0..<5 {
            let frame = CGRect(
                x: CGFloat(index) * 89,
                y: 0,
                width: 89,
                height: 31
            )
            let headerCell = HeaderCell(frame: frame)
            headerCell.configure(
                attributedText: NSMutableAttributedString().regular(string: "dd", fontSize: 11),
                backgroundColor: .brown,
                borderWith: 1,
                borderColor: .blue
            )
            addSubview(headerCell)
        }
    }

}
