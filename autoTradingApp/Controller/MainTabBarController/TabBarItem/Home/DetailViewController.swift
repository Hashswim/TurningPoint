//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit

class DetailViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SK"

        return label
    }()

    private let stockPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "100,300 원"

        return label
    }()

    private let stockInfoView = StockInfoView()

    private let segmentedControl = mainTabSegmentedControl(items: ["차트", "호가"])

    private let chartView = ChartView2()
    private let transactionView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan

        setUpUI()
        configureLayout()
    }
    
    func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(stockPriceLabel)
        contentView.addSubview(stockInfoView)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(chartView)
        contentView.addSubview(transactionView)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    func configureLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stockInfoView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        transactionView.translatesAutoresizingMaskIntoConstraints = false

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

            stockNameLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stockNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 200),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 20),

            stockPriceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor),
            stockPriceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockPriceLabel.widthAnchor.constraint(equalToConstant: 200),
            stockPriceLabel.heightAnchor.constraint(equalToConstant: 20),

            stockInfoView.topAnchor.constraint(equalTo: stockPriceLabel.bottomAnchor),
            stockInfoView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockInfoView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stockInfoView.heightAnchor.constraint(equalToConstant: 280),

            segmentedControl.topAnchor.constraint(equalTo: stockInfoView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20),

            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            chartView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            chartView.heightAnchor.constraint(equalToConstant: 400),

            transactionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            transactionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            transactionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            transactionView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }

    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            chartView.isHidden = false
            transactionView.isHidden = true
        case 1:
            chartView.isHidden = true
            transactionView.isHidden = false
        default:
            return
        }
    }

}
