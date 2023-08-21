//
//  StockInfoView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/25.
//

import UIKit

class StockInfoView: UIView {

    private let largeContainerStackView1 = UIStackView()
    private let containerStackView1 = UIStackView()
    private let countLabelTitle: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "보유수량", fontSize: 13)
        label.textColor = .gray
        label.textAlignment = .left

        return label
    }()

    let countLabel: UILabel = {
        let label = UILabel()
//        label.attributedText = NSMutableAttributedString().regular(string: "2 주", fontSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .left

        return label
    }()

    private let containerStackView2 = UIStackView()
    private let priceLabelTitle: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "보유금액", fontSize: 13)
        label.textColor = .gray
        label.textAlignment = .left

        return label
    }()

    let priceLabel: UILabel = {
        let label = UILabel()
//        label.attributedText = NSMutableAttributedString().regular(string: "100,580 원", fontSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .left

        return label
    }()

    private let largeContainerStackView2 = UIStackView()
    private let containerStackView3 = UIStackView()
    private let earningPriceLabelTitle: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "수익", fontSize: 13)
        label.textColor = .gray
        label.textAlignment = .left

        return label
    }()

    let earningPriceLabel: UILabel = {
        let label = UILabel()
//        label.attributedText = NSMutableAttributedString().regular(string: "-37,684 원", fontSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .left

        return label
    }()

    private let containerStackView4 = UIStackView()
    private let earningRateLabelTitle: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString().regular(string: "수익률", fontSize: 13)
        label.textColor = .gray
        label.textAlignment = .left

        return label
    }()

    let earningRateLabel: UILabel = {
        let label = UILabel()
//        label.attributedText = NSMutableAttributedString().regular(string: "-1.45 %", fontSize: 20)
        label.textColor = .lightGray
        label.textAlignment = .left

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

    func setUpUI() {
        largeContainerStackView1.translatesAutoresizingMaskIntoConstraints = false
        largeContainerStackView2.translatesAutoresizingMaskIntoConstraints = false

        containerStackView1.translatesAutoresizingMaskIntoConstraints = false
        containerStackView2.translatesAutoresizingMaskIntoConstraints = false
        containerStackView3.translatesAutoresizingMaskIntoConstraints = false
        containerStackView4.translatesAutoresizingMaskIntoConstraints = false

        containerStackView1.axis = .vertical
        containerStackView2.axis = .vertical
        containerStackView3.axis = .vertical
        containerStackView4.axis = .vertical

//        containerStackView1.spacing = 4
//        containerStackView2.spacing = 4
//        containerStackView3.spacing = 4
//        containerStackView4.spacing = 4

        largeContainerStackView1.axis = .horizontal
        largeContainerStackView2.axis = .horizontal

        self.addSubview(largeContainerStackView1)
        self.addSubview(largeContainerStackView2)

        largeContainerStackView1.addArrangedSubview(containerStackView1)
        largeContainerStackView1.addArrangedSubview(containerStackView2)

        containerStackView1.addArrangedSubview(countLabelTitle)
        containerStackView1.addArrangedSubview(countLabel)

        containerStackView2.addArrangedSubview(priceLabelTitle)
        containerStackView2.addArrangedSubview(priceLabel)

        largeContainerStackView2.addArrangedSubview(containerStackView3)
        largeContainerStackView2.addArrangedSubview(containerStackView4)

        containerStackView3.addArrangedSubview(earningPriceLabelTitle)
        containerStackView3.addArrangedSubview(earningPriceLabel)

        containerStackView4.addArrangedSubview(earningRateLabelTitle)
        containerStackView4.addArrangedSubview(earningRateLabel)

    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            largeContainerStackView1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            largeContainerStackView1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            largeContainerStackView1.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            largeContainerStackView1.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.44),

            containerStackView1.widthAnchor.constraint(equalToConstant: 160),
            containerStackView3.widthAnchor.constraint(equalToConstant: 160),

            containerStackView1.heightAnchor.constraint(equalToConstant: 40),
            containerStackView2.heightAnchor.constraint(equalToConstant: 40),
            containerStackView3.heightAnchor.constraint(equalToConstant: 40),
            containerStackView4.heightAnchor.constraint(equalToConstant: 40),

            largeContainerStackView2.topAnchor.constraint(equalTo: largeContainerStackView1.bottomAnchor, constant: 32),
            largeContainerStackView2.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            largeContainerStackView2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            largeContainerStackView2.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            largeContainerStackView2.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.44),
        ])
    }

}
