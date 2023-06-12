//
//  TradingViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit

class TradingViewController: UIViewController {

    let chart = ChartView2()

    override func viewDidLoad() {
        super.viewDidLoad()

        chart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chart)

        NSLayoutConstraint.activate([
            chart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            chart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
