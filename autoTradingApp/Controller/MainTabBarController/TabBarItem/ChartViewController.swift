//
//  ChartViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/04.
//

import UIKit

class ChartViewController: UIViewController {

    private let chartView = ChartView()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
    }

    func configureHierarchy() {
        view.addSubview(chartView)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }



}
