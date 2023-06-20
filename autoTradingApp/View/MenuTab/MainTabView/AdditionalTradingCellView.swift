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
        label.attributedText = NSMutableAttributedString().regular(string: "기본형 알고리즘", fontSize: 12)
        label.textColor = MySpecialColors.textGray2
        label.textAlignment = .center
        label.backgroundColor = MySpecialColors.bgGray
        label.layer.borderColor = MySpecialColors.borderGray.cgColor
        label.layer.borderWidth = 1.0
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 8

        return label
    }()

    private lazy var containerStackView = UIStackView(arrangedSubviews: [earningPirceStackView,
                                                                         earningRateStackView,
                                                                         ownedCountStackView])
    private lazy var earningPirceStackView = UIStackView()
    private let earningPirceTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "현재 수익", fontSize: 11)
        label.textColor = MySpecialColors.textGray

        return label
    }()

    private let earningPirceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "300,000", fontSize: 17)
            .medium(string: " 원", fontSize: 15)
        label.textColor = .white

        return label
    }()

    private let earningRateStackView = UIStackView()
    private let earningRateTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "현재 수익률", fontSize: 11)
        label.textColor = MySpecialColors.textGray

        return label
    }()

    private let earningRateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "+5.4", fontSize: 17)
            .medium(string: "%", fontSize: 15)
        label.textColor = .white

        return label
    }()

    private let ownedCountStackView = UIStackView()
    private let ownedCountTitleLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "보유 수량", fontSize: 11)
        label.textColor = MySpecialColors.textGray

        return label
    }()

    private let ownedCountLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "4", fontSize: 17)
            .medium(string: " 주", fontSize: 15)
        label.textColor = .white

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

//        containerStackView.setCustomSpacing(68, after: earningPirceStackView)
//        containerStackView.setCustomSpacing(32, after: earningRateStackView)

        containerStackView.backgroundColor = MySpecialColors.cellGray
        containerStackView.layer.masksToBounds = true
        containerStackView.layer.cornerRadius = 8

        earningPirceStackView.spacing = 8
        earningRateStackView.spacing = 8
        ownedCountStackView.spacing = 8

        earningPirceStackView.alignment = .leading
        earningRateStackView.alignment = .leading
        ownedCountStackView.alignment = .leading

        earningPirceStackView.axis = .vertical
        earningRateStackView.axis = .vertical
        ownedCountStackView.axis = .vertical

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
            algorithmTypeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 4),
            algorithmTypeLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            algorithmTypeLabel.widthAnchor.constraint(equalToConstant: 100),
            algorithmTypeLabel.heightAnchor.constraint(equalToConstant: 20),

            containerStackView.topAnchor.constraint(equalTo: algorithmTypeLabel.bottomAnchor, constant: 8),
            containerStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            containerStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -21),
            containerStackView.heightAnchor.constraint(equalToConstant: 64),
            containerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -18),

            earningPirceStackView.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 16),
            earningPirceStackView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -16),
            earningPirceStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 28),
            earningPirceStackView.widthAnchor.constraint(equalToConstant: 96),

            earningPirceTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            earningPirceTitleLabel.topAnchor.constraint(equalTo: earningPirceStackView.topAnchor),
            earningPirceLabel.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -24),

            earningRateStackView.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 16),
            earningRateStackView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -16),
            earningRateStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 171),
            earningRateStackView.widthAnchor.constraint(equalToConstant: 60),

            earningRateTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            earningRateTitleLabel.topAnchor.constraint(equalTo: earningRateStackView.topAnchor),
            earningRateLabel.topAnchor.constraint(equalTo: earningRateTitleLabel.bottomAnchor, constant: 7),
            earningRateLabel.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -24),

            ownedCountStackView.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 16),
            ownedCountStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 275),
            ownedCountStackView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -16),
            ownedCountStackView.widthAnchor.constraint(equalToConstant: 46),

            ownedCountTitleLabel.heightAnchor.constraint(equalToConstant: 15),
            ownedCountTitleLabel.topAnchor.constraint(equalTo: ownedCountStackView.topAnchor),
            ownedCountLabel.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -24),

        ])
    }

}
