//
//  ChartView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/06.
//

import UIKit
import LightweightCharts

class ChartView: UIView {

    var chart: LightweightCharts!

    // ...

    // ... setup layout
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
        setUpData()
        self.addSubview(chart)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        chart = LightweightCharts()
    }

    func setUpData() {
        var series: BarSeries!

        series = chart.addBarSeries(options: nil)

        let data = [
            BarData(time: .string("2018-10-19"), open: 180.34, high: 180.99, low: 178.57, close: 179.85),
            BarData(time: .string("2018-10-22"), open: 180.82, high: 181.40, low: 177.56, close: 178.75),
            BarData(time: .string("2018-10-23"), open: 175.77, high: 179.49, low: 175.44, close: 178.53),
            BarData(time: .string("2018-10-24"), open: 178.58, high: 182.37, low: 176.31, close: 176.97),
            BarData(time: .string("2018-10-25"), open: 177.52, high: 180.50, low: 176.83, close: 179.07)
        ]

        // ...
        series.setData(data: data)
    }

}
