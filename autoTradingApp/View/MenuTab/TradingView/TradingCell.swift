//
//  TradingCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/07/08.
//

import UIKit

public class TradingCell: UITableViewCell {
    public static let cellID = "Trading-cell-identifier"

    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = MySpecialColors.tradingGray
        label.textAlignment = .center

        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = MySpecialColors.tradingGray
        label.textAlignment = .center

        return label
    }()
    let actionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = MySpecialColors.tradingGray
        label.textAlignment = .center

        return label
    }()

    let investmentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.textColor = MySpecialColors.tradingGray
        label.textAlignment = .center

        return label
    }()

    let spacingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MySpecialColors.bgColor

        return view
    }()

    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TradingCell {
    func configureCell() {
        self.backgroundColor = MySpecialColors.darkGray

        contentView.addSubview(dateLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(actionLabel)
        contentView.addSubview(investmentLabel)
        contentView.addSubview(spacingView)

        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 33.8),
            dateLabel.widthAnchor.constraint(equalToConstant: 58),
            dateLabel.heightAnchor.constraint(equalToConstant: 17),
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor, constant: 43),
            priceLabel.widthAnchor.constraint(equalToConstant: 42),
            priceLabel.heightAnchor.constraint(equalToConstant: 17),
            priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            actionLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 40),
            actionLabel.widthAnchor.constraint(equalToConstant: 30),
            actionLabel.heightAnchor.constraint(equalToConstant: 17),
            actionLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            actionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            investmentLabel.leadingAnchor.constraint(equalTo: actionLabel.trailingAnchor, constant: 40),
            investmentLabel.widthAnchor.constraint(equalToConstant: 53),
            investmentLabel.heightAnchor.constraint(equalToConstant: 17),
            investmentLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            investmentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            spacingView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            spacingView.heightAnchor.constraint(equalToConstant: 4),
            spacingView.widthAnchor.constraint(equalTo: contentView.widthAnchor),

        ])
    }
}
