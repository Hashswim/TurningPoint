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
        label.text = "보유수량"

        return label
    }()

    private let countLabel: UILabel = {
        let label = UILabel()
        label.text = "2 주"
        return label
    }()

    private let containerStackView2 = UIStackView()
    private let priceLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "보유금액"

        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "100,580 원"
        return
    }()

    private let largeContainerStackView2 = UIStackView()
    private let containerStackView3 = UIStackView()
    private let earningPriceLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "수익"
        return label
    }()

    private let earningPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "37,684 원"
        return label
    }()

    private let containerStackView4 = UIStackView()
    private let earningRateLabelTitle: UILabel = {
        let label = UILabel()
        label.text = "수익률"
        return label
    }()

    private let earningRateLabel: UILabel = {
        let label = UILabel()
        label.text = "+ 1.45%"
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

        largeContainerStackView1.axis = .horizontal
        largeContainerStackView2.axis = .horizontal

        self.addSubview(largeContainerStackView1)
        self.addSubview(largeContainerStackView2)

        largeContainerStackView1.addArrangedSubview(containerStackView1)
        largeContainerStackView1.addArrangedSubview(containerStackView2)

        containerStackView1.addArrangedSubview(countLabelTitle)
        containerStackView1.addArrangedSubview(countLabel)

        containerStackView2.addArrangedSubview(countLabelTitle)
        containerStackView2.addArrangedSubview(countLabel)

        largeContainerStackView2.addArrangedSubview(containerStackView3)
        largeContainerStackView2.addArrangedSubview(containerStackView4)

        containerStackView3.addArrangedSubview(countLabelTitle)
        containerStackView4.addArrangedSubview(countLabel)

        containerStackView4.addArrangedSubview(countLabelTitle)
        containerStackView4.addArrangedSubview(countLabel)

    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            largeContainerStackView1.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            largeContainerStackView1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            largeContainerStackView1.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            largeContainerStackView1.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),

            largeContainerStackView1.topAnchor.constraint(equalTo: largeContainerStackView1.bottomAnchor),
            largeContainerStackView1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            largeContainerStackView1.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            largeContainerStackView1.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            largeContainerStackView1.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
        ])
    }

}
