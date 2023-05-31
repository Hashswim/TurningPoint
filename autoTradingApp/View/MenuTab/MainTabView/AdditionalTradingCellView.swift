//
//  additionalTradingCellView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/31.
//

import UIKit

class AdditionalTradingCellView: UIView {

    private let algorithmTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "기본형 알고리즘"

        return label
    }()

    private lazy var containerStackView = UIStackView(arrangedSubviews: [earningPirceStackView,
                                                                         earningRateStackView,
                                                                         ownedCountStackView])
    private lazy var earningPirceStackView = UIStackView()
    private let earningPirceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 수익"

        return label
    }()

    private let earningPirceLabel: UILabel = {
        let label = UILabel()
        label.text = "300,000 원"

        return label
    }()

    private let earningRateStackView = UIStackView()
    private let earningRateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "현재 수익률"

        return label
    }()

    private let earningRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+5.4 %"

        return label
    }()

    private let ownedCountStackView = UIStackView()
    private let ownedCountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "보유수량"

        return label
    }()

    private let ownedCountLabel: UILabel = {
        let label = UILabel()
        label.text = "4 주"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpUI() {
        self.addSubview(algorithmTypeLabel)
        self.addSubview(containerStackView)

        containerStackView.axis = .horizontal

        earningPirceStackView.addArrangedSubview(earningPirceTitleLabel)
        earningPirceStackView.addArrangedSubview(earningPirceLabel)

        earningRateStackView.addArrangedSubview(earningRateTitleLabel)
        earningRateStackView.addArrangedSubview(earningRateLabel)

        ownedCountStackView.addArrangedSubview(ownedCountTitleLabel)
        ownedCountStackView.addArrangedSubview(ownedCountLabel)
    }

    private func configureLayout() {
        algorithmTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            algorithmTypeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            algorithmTypeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            algorithmTypeLabel.widthAnchor.constraint(equalToConstant: 100),
            algorithmTypeLabel.heightAnchor.constraint(equalToConstant: 20),

            containerStackView.topAnchor.constraint(equalTo: algorithmTypeLabel.bottomAnchor, constant: 8),
            containerStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

}
