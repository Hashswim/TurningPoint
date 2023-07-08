//
//  TradingCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/08.
//

import UIKit

public class TradingCell: UICollectionViewCell {
    let label = UILabel()
    public static let reuseIdentifier = "Trading-cell-reuse-identifier"

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }

}

extension TradingCell {
    func configureCell() {
        self.backgroundColor = .gray

        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true

        label.textAlignment = .center
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
