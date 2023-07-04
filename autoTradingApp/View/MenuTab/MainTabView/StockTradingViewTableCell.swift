//
//  StockTradingViewTableCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/16.
//

import UIKit

class StockTradingViewTableCell: UITableViewCell {

    static let cellID = "predictedCellID"

    var isTouched: Bool = false

    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MySpecialColors.darkGray
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 0
        view.layer.borderColor = UIColor.white.cgColor

        return view
    }()

    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .preferredFont(forTextStyle: .largeTitle)

        return label
    }()

    private let predictedTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "예상 수익률"

        return label
    }()

    let percentageLabel: UILabel = {
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
        self.backgroundColor = MySpecialColors.bgColor

        self.addSubview(containerView)
        containerView.addSubview(typeLabel)
        containerView.addSubview(predictedTextLabel)
        containerView.addSubview(percentageLabel)

        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 52),

            containerView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            containerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 2),
            containerView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -2),
            containerView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),

            typeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            typeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            typeLabel.widthAnchor.constraint(equalToConstant: 98),
            typeLabel.heightAnchor.constraint(equalToConstant: 18),

            predictedTextLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            predictedTextLabel.leadingAnchor.constraint(equalTo: typeLabel.trailingAnchor, constant: 110),
            predictedTextLabel.widthAnchor.constraint(equalToConstant: 52),
            predictedTextLabel.heightAnchor.constraint(equalToConstant: 11),

            percentageLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            percentageLabel.leadingAnchor.constraint(equalTo: predictedTextLabel.trailingAnchor, constant: 4),
            percentageLabel.widthAnchor.constraint(equalToConstant: 60),
            percentageLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func touched() {
        if isTouched {
            containerView.backgroundColor = .gray
            containerView.layer.borderWidth = 1

        } else {
            containerView.backgroundColor = MySpecialColors.darkGray
            containerView.layer.borderWidth = 0
        }
    }
}
