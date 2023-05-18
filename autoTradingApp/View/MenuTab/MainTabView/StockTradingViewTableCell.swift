//
//  StockTradingViewTableCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/16.
//

import UIKit

class StockTradingViewTableCell: UITableViewCell {

    static let cellID = "predictedCellID"

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)

        return label
    }()

    private let algorithmTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "알고리즘"

        return label
    }()

    let predictedTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "예상 수익률"

        return label
    }()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func layout() {
        self.addSubview(typeLabel)
        self.addSubview(algorithmTextLabel)
        self.addSubview(predictedTextLabel)
        self.addSubview(percentageLabel)

        NSLayoutConstraint.activate([
            typeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            typeLabel.widthAnchor.constraint(equalToConstant: 80),
            typeLabel.heightAnchor.constraint(equalToConstant: 40),

            algorithmTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            algorithmTextLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 10),
            algorithmTextLabel.widthAnchor.constraint(equalToConstant: 80),
            algorithmTextLabel.heightAnchor.constraint(equalToConstant: 40),

            predictedTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            predictedTextLabel.leadingAnchor.constraint(equalTo: percentageLabel.leadingAnchor, constant: -10),
            predictedTextLabel.widthAnchor.constraint(equalToConstant: 80),
            predictedTextLabel.heightAnchor.constraint(equalToConstant: 40),

            percentageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            percentageLabel.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            percentageLabel.widthAnchor.constraint(equalToConstant: 80),
            percentageLabel.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}
