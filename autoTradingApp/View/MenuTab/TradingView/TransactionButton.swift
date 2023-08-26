//
//  TransactionStackView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/08/25.
//

import UIKit

class TransactionButton: UIButton {
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .center
//        view.distribution = .fill
//        view.spacing = 12
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버"
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "210,000원"
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true

        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "3개"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true

        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let orderLabel: UILabel = {
        let label = UILabel()
        label.text = "매수"
        label.textAlignment = .left
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func setUp() {
        addSubview(stackView)
        [nameLabel, priceLabel, countLabel, orderLabel].forEach(stackView.addArrangedSubview(_:))

        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10

        self.backgroundColor = MySpecialColors.bgGray

        NSLayoutConstraint.activate([
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),

            nameLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 18),
            nameLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            nameLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            nameLabel.widthAnchor.constraint(equalToConstant: 60),

            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            priceLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            priceLabel.widthAnchor.constraint(equalToConstant: 60),

            countLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 16),
            countLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            countLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            countLabel.widthAnchor.constraint(equalToConstant: 30),

            orderLabel.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 4),
            orderLabel.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 12),
            orderLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -12),
            orderLabel.widthAnchor.constraint(equalToConstant: 40),

        ])
    }

}
