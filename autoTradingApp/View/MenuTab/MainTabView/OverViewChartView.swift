////
////  OverViewChartView.swift
////  autoTradingApp
////
////  Created by 서수영 on 2023/03/09.
////
//
//import UIKit
//import LightweightCharts
//
//class OverViewChartView: UIView {
//    private var chart: LightweightCharts!
//    private var areaSeries: AreaSeries!
//    private let dateFormatter: DateFormatter = {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .full
//        return dateFormatter
//    }()
//
////    override func viewDidLoad() {
////        super.viewDidLoad()
////        if #available(iOS 13.0, *) {
////            view.backgroundColor = .systemBackground
////        } else {
////            view.backgroundColor = .white
////        }
////
////        setupUI()
////        setupData()
////    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        setupUI()
//        setupData()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//
//
//    private func setupUI() {
//        self.isUserInteractionEnabled = false
//        self.backgroundColor = .clear
//
//        let options = ChartOptions(
//            layout: LayoutOptions(backgroundColor: "#fafafa"),
//            leftPriceScale: VisiblePriceScaleOptions(visible: false),
//            rightPriceScale: VisiblePriceScaleOptions(visible: false),
//            timeScale: TimeScaleOptions(visible: false),
//            crosshair: CrosshairOptions(
//                vertLine: CrosshairLineOptions(visible: false),
//                horzLine: CrosshairLineOptions(visible: false)
//            ),
//            grid: GridOptions(
//                verticalLines: GridLineOptions(color: "#fff"),
//                horizontalLines: GridLineOptions(color: "#fff")
//            )
//        )
//        let chart = LightweightCharts(options: options)
//
//        self.addSubview(chart)
//        chart.translatesAutoresizingMaskIntoConstraints = false
//        if #available(iOS 11.0, *) {
//            NSLayoutConstraint.activate([
//                chart.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//                chart.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//                chart.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//                chart.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
//            ])
//        } else {
//            NSLayoutConstraint.activate([
//                chart.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//                chart.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//                chart.topAnchor.constraint(equalTo: self.topAnchor),
//                chart.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//            ])
//        }
//        self.chart = chart
//    }
//
//    private func setupData() {
//        let areaSeriesOptions = AreaSeriesOptions(
//            topColor: "rgba(76, 175, 80, 0.5)",
//            bottomColor: "rgba(76, 175, 80, 0)",
//            lineColor: "rgba(76, 175, 80, 1)",
//            lineWidth: .two
//        )
//        let areaSeries = chart.addAreaSeries(options: areaSeriesOptions)
//        let areaData = [
//            SingleValueData(time: .string("2018-10-19"), value: 219.31),
//            SingleValueData(time: .string("2018-10-22"), value: 220.65),
//            SingleValueData(time: .string("2018-10-23"), value: 222.73),
//            SingleValueData(time: .string("2018-10-24"), value: 215.09),
//            SingleValueData(time: .string("2018-10-25"), value: 219.80),
//            SingleValueData(time: .string("2018-10-26"), value: 216.30),
//            SingleValueData(time: .string("2018-10-29"), value: 212.24),
//            SingleValueData(time: .string("2018-10-30"), value: 213.30),
//            SingleValueData(time: .string("2018-10-31"), value: 218.86),
//            SingleValueData(time: .string("2018-11-01"), value: 222.22),
//            SingleValueData(time: .string("2018-11-02"), value: 207.48),
//            SingleValueData(time: .string("2018-11-05"), value: 201.59),
//            SingleValueData(time: .string("2018-11-06"), value: 203.77),
//            SingleValueData(time: .string("2018-11-07"), value: 209.95),
//            SingleValueData(time: .string("2018-11-08"), value: 208.49),
//            SingleValueData(time: .string("2018-11-09"), value: 204.47),
//            SingleValueData(time: .string("2018-11-12"), value: 194.17),
//            SingleValueData(time: .string("2018-11-13"), value: 192.23),
//            SingleValueData(time: .string("2018-11-14"), value: 186.80),
//            SingleValueData(time: .string("2018-11-15"), value: 191.41),
//            SingleValueData(time: .string("2018-11-16"), value: 193.53),
//            SingleValueData(time: .string("2018-11-19"), value: 185.86),
//
//        ]
//        areaSeries.setData(data: areaData)
//        self.areaSeries = areaSeries
//    }
//}
//
//
