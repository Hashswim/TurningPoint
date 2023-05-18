//
//  StockTradingViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/19.
//

import UIKit

class StockTradingViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "LG에너지솔루션"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private let algorithmTypeLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 3
        label.textAlignment = .center
        label.text = "공격형 알고리즘"
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    lazy var tradingButton: UIButton = {
        let btn = UIButton(type: .custom)
        btn.translatesAutoresizingMaskIntoConstraints = false

        var config = UIButton.Configuration.plain()
        config.title = "Trading"
        config.subtitle = "Off"
        config.titleAlignment = .center

        btn.configuration = config

        btn.backgroundColor = .systemCyan
        btn.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)

        return btn
    }()

    private let returnRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "수익률"
        label.textAlignment = .center

        return label
    }()

    private let percentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "0.0%"

        return label
    }()

    private let algorithmTitleLabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        label.text = "트레이딩 알고리즘"
        label.textColor = .white

        return label
    }()

    let tradingStrategyTableView = UITableView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tradingButton.layer.cornerRadius = tradingButton.frame.size.width/2
        tradingButton.clipsToBounds = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MySpecialColors.bgColor
        tradingStrategyTableView.register(StockTradingViewTableCell.self, forCellReuseIdentifier: StockTradingViewTableCell.cellID)
        tradingStrategyTableView.delegate = self
        tradingStrategyTableView.dataSource = self

        configureHierarchy()
        configureLayout()
    }

    @objc
    func toggleButton() {

    }

    func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(algorithmTypeLabel)
        contentView.addSubview(tradingButton)
        contentView.addSubview(returnRateLabel)
        contentView.addSubview(percentageLabel)
        contentView.addSubview(algorithmTitleLabel)
        contentView.addSubview(tradingStrategyTableView)
    }

    func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        tradingStrategyTableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor),

            stockNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 72),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 196),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 16),
            stockNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            algorithmTypeLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 20),
            algorithmTypeLabel.widthAnchor.constraint(equalToConstant: 120),
            algorithmTypeLabel.heightAnchor.constraint(equalToConstant: 20),
            algorithmTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            tradingButton.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 192),
            tradingButton.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 108),
            tradingButton.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -108),
            tradingButton.heightAnchor.constraint(equalTo: tradingButton.widthAnchor),

            returnRateLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 422),
            returnRateLabel.widthAnchor.constraint(equalToConstant: 100),
            returnRateLabel.heightAnchor.constraint(equalToConstant: 52),
            returnRateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            percentageLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 444),
            percentageLabel.widthAnchor.constraint(equalToConstant: 100),
            percentageLabel.heightAnchor.constraint(equalToConstant: 52),
            percentageLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            algorithmTitleLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 500),
            algorithmTitleLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            algorithmTitleLabel.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16),

            tradingStrategyTableView.topAnchor.constraint(equalTo: algorithmTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 80),
            tradingStrategyTableView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 16),
            tradingStrategyTableView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -16),
            tradingStrategyTableView.heightAnchor.constraint(equalToConstant: 280)

        ])
    }

}

//⭐️트레이딩 알고리즘 모델 값을 stock 모델이 소유해야 할듯?
extension StockTradingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tradingStrategyTableView.dequeueReusableCell(withIdentifier: StockTradingViewTableCell.cellID, for: indexPath) as! StockTradingViewTableCell

        cell.predictedTextLabel.text = PredictedAlgorithm.attack.rawValue
        return cell
    }
}
