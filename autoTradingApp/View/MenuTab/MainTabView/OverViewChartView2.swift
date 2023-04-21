//
//  OverViewChartViewWithCharts.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/23.
//

import UIKit
import Charts
import TinyConstraints

class OverViewChartView2: UIViewController, ChartViewDelegate {

    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue

        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.xAxis.enabled = false
        chartView.legend.drawInside = false
        chartView.chartDescription.enabled = false
        chartView.legend.enabled = false

        chartView.animate(xAxisDuration: 2.5)

        return chartView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)

        setData()
    }

    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }

    func setData() {
        let set1 = LineChartDataSet(entries: yValues1)
        set1.mode = .cubicBezier
        set1.drawCirclesEnabled = false
        set1.lineWidth = 3

        set1.setColor(.white)

        let set2 = LineChartDataSet(entries: yValues2)
        set2.mode = .cubicBezier
        set2.drawCirclesEnabled = false
        set2.lineWidth = 3

        set2.setColor(.red)

        let data = LineChartData(dataSets: [set1, set2])
        data.setDrawValues(false)
        lineChartView.data = data
    }

    let yValues1: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 10.2),
        ChartDataEntry(x: 2.0, y: 10.2),
        ChartDataEntry(x: 4.0, y: 10.2),
        ChartDataEntry(x: 5.0, y: 10.2),
        ChartDataEntry(x: 6.0, y: 10.2),
        ChartDataEntry(x: 7.0, y: 10.2),
        ChartDataEntry(x: 8.0, y: 10.2),
        ChartDataEntry(x: 9.0, y: 10.2),
        ChartDataEntry(x: 10.0, y: 10.2),
        ChartDataEntry(x: 20.0, y: 10.2),
        ChartDataEntry(x: 30.0, y: 10.2),
        ChartDataEntry(x: 40.0, y: 10.2),
        ChartDataEntry(x: 50.0, y: 10.2),
        ChartDataEntry(x: 60.0, y: 10.2),
        ChartDataEntry(x: 70.0, y: 10.2),
        ChartDataEntry(x: 80.0, y: 10.2),
        ChartDataEntry(x: 90.0, y: 10.2),
        ChartDataEntry(x: 100.0, y: 10.2),
        ChartDataEntry(x: 102.0, y: 10.2),
        ChartDataEntry(x: 104.0, y: 10.2),
        ChartDataEntry(x: 106.0, y: 10.2),
        ChartDataEntry(x: 109.0, y: 10.2),
    ]

    let yValues2: [ChartDataEntry] = [
        ChartDataEntry(x: 0.0, y: 20.5),
        ChartDataEntry(x: 2.0, y: 20.5),
        ChartDataEntry(x: 4.0, y: 20.5),
        ChartDataEntry(x: 5.0, y: 20.5),
        ChartDataEntry(x: 6.0, y: 20.5),
        ChartDataEntry(x: 7.0, y: 20.5),
        ChartDataEntry(x: 8.0, y: 20.5),
        ChartDataEntry(x: 9.0, y: 20.5),
        ChartDataEntry(x: 10.0, y: 20.5),
        ChartDataEntry(x: 20.0, y: 20.5),
        ChartDataEntry(x: 30.0, y: 20.5),
        ChartDataEntry(x: 40.0, y: 20.5),
        ChartDataEntry(x: 50.0, y: 20.5),
        ChartDataEntry(x: 60.0, y: 20.5),
        ChartDataEntry(x: 70.0, y: 20.5),
        ChartDataEntry(x: 80.0, y: 20.5),
        ChartDataEntry(x: 90.0, y: 20.5),
        ChartDataEntry(x: 100.0, y: 20.5),
        ChartDataEntry(x: 102.0, y: 20.5),
        ChartDataEntry(x: 104.0, y: 20.5),
        ChartDataEntry(x: 106.0, y: 20.5),
        ChartDataEntry(x: 109.0, y: 20.5),
    ]

}

