//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit

class DetailViewController: UIViewController {

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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemCyan

        setUpUI()
        configureLayout()
    }
    
    func setUpUI() {
        view.addSubview(stockNameLabel)
        view.addSubview(stockPriceLabel)
        view.addSubview(stockInfoView)
    }

    func configureLayout() {
        stockInfoView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stockNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stockNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 200),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 20),

            stockPriceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor),
            stockPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockPriceLabel.widthAnchor.constraint(equalToConstant: 200),
            stockPriceLabel.heightAnchor.constraint(equalToConstant: 20),

            stockInfoView.topAnchor.constraint(equalTo: stockPriceLabel.bottomAnchor),
            stockInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stockInfoView.heightAnchor.constraint(equalToConstant: 280),

        ])
    }

}
