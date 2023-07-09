//
//  TradingCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/08.
//

import UIKit

public class TradingCell: UICollectionViewCell {
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
    let actionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
    let investmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .white
        label.textAlignment = .center

        return label
    }()

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
        self.backgroundColor = MySpecialColors.darkGray
        self.layer.borderWidth = 2
        self.layer.borderColor = MySpecialColors.bgColor.cgColor

        contentView.addSubview(dateLabel)
        contentView.addSubview(actionLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(investmentLabel)
        contentView.addSubview(balanceLabel)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: 89),
            dateLabel.heightAnchor.constraint(equalToConstant: 32),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            actionLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            actionLabel.widthAnchor.constraint(equalToConstant: 89),
            actionLabel.heightAnchor.constraint(equalToConstant: 32),
            actionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: actionLabel.trailingAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 89),
            priceLabel.heightAnchor.constraint(equalToConstant: 32),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            investmentLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor),
            investmentLabel.widthAnchor.constraint(equalToConstant: 89),
            investmentLabel.heightAnchor.constraint(equalToConstant: 32),
            investmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            investmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            balanceLabel.leadingAnchor.constraint(equalTo: investmentLabel.trailingAnchor),
            balanceLabel.widthAnchor.constraint(equalToConstant: 89),
            balanceLabel.heightAnchor.constraint(equalToConstant: 32),
            balanceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            balanceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
