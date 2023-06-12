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

        return label
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

        containerStackView1.translatesAutoresizingMaskIntoConstraints = false
        containerStackView2.translatesAutoresizingMaskIntoConstraints = false
        containerStackView3.translatesAutoresizingMaskIntoConstraints = false
        containerStackView4.translatesAutoresizingMaskIntoConstraints = false

        containerStackView1.axis = .vertical
        containerStackView2.axis = .vertical
        containerStackView3.axis = .vertical
        containerStackView4.axis = .vertical

        containerStackView1.spacing = 4
        containerStackView2.spacing = 4
        containerStackView3.spacing = 4
        containerStackView4.spacing = 4

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
            largeContainerStackView1.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            largeContainerStackView1.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            largeContainerStackView1.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),

            largeContainerStackView2.topAnchor.constraint(equalTo: largeContainerStackView1.bottomAnchor),
            largeContainerStackView2.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            largeContainerStackView2.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            largeContainerStackView2.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            largeContainerStackView2.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
        ])
    }

}
