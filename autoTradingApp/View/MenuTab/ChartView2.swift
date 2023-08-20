//
//  ChartView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/06.
//

import UIKit
import LightweightCharts

class ChartView2: UIView {

    private var chart: LightweightCharts!
    private var series: CandlestickSeries!
    var chartData: [DateChart] = []
    // ...

    // ... setup layout
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureLayout()
        setupChart()
        setupData()
        self.addSubview(chart)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureLayout() {
        chart = LightweightCharts()
    }

    private func setupChart() {
        let options = ChartOptions(
            layout: LayoutOptions(backgroundColor: "#FFFFFF", textColor: "rgba(0, 0, 0, 0.9)"),
            rightPriceScale: VisiblePriceScaleOptions(borderColor: "rgba(197, 203, 206, 0.8)"),
            timeScale: TimeScaleOptions(borderColor: "rgba(197, 203, 206, 0.8)"),
            crosshair: CrosshairOptions(mode: .normal),
            grid: GridOptions(
                verticalLines: GridLineOptions(color: "rgba(197, 203, 206, 0.5)"),
                horizontalLines: GridLineOptions(color: "rgba(197, 203, 206, 0.5)")
            )
        )
        let chart = LightweightCharts(options: options)
        self.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
                chart.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
                chart.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                chart.topAnchor.constraint(equalTo: self.topAnchor),
                chart.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            ])
        }
        self.chart = chart
    }

    func setupData() {
        let options = CandlestickSeriesOptions(
            upColor: "rgba(255, 144, 0, 1)",
            downColor: "#000",
            borderUpColor: "rgba(255, 144, 0, 1)",
            borderDownColor: "rgba(255, 144, 0, 1)",
            wickUpColor: "rgba(255, 144, 0, 1)",
            wickDownColor: "rgba(255, 144, 0, 1)"
        )
        let series = chart.addCandlestickSeries(options: options)

        let data: [CandlestickData] = chartData.compactMap {
            var time = $0.date
            let dash: Character = "-"
            var idx = time.index(time.startIndex, offsetBy: 4)
            time.insert(dash, at: idx)

            idx = time.index(time.startIndex, offsetBy: 7)
            time.insert(dash, at: idx)

            return CandlestickData(time: .string(time), open: $0.open, high: $0.high, low: $0.low, close: $0.close)
        }

        series.setData(data: data)
        self.series = series
    }

}
