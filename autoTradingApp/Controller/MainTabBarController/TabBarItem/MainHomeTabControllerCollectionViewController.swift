//
//  MainHomeTabControllerCollectionViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/09.
//

import UIKit

private let reuseIdentifier = "Cell"

private enum Section: Hashable {
    case main
}

class MainHomeTabControllerCollectionViewController: UIViewController {

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이수림님"
        label.font = .systemFont(ofSize: 20)
        return label
    }()

    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.03.09"
        label.font = .systemFont(ofSize: 10)

        return label
    }()

    private let refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        return btn
    }()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, timeLabel, refreshButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private let segmentedControl = mainTabSegmentedControl(items: ["내주식", "즐겨찾기", "트레이딩 주식"])

    private let headerStcokLabel: UILabel = {
        let label = UILabel()
        label.text = "주식명"

        return label
    }()

    private let headerChartLabel: UILabel = {
        let label = UILabel()
        label.text = "차트"

        return label
    }()

    private let headerPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "현재가"

        return label
    }()

    lazy var headerLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStcokLabel, headerChartLabel, headerPriceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Stock>! = nil
    private var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.title = "main tab"
        configureHierarchy()
        configureDataSource()
        configureLayout()
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
//        config.headerMode = .supplementary
        return UICollectionViewCompositionalLayout.list(using: config)
    }
}

extension MainHomeTabControllerCollectionViewController {
    private func configureHierarchy() {
        view.backgroundColor = .white
        view.addSubview(containerStackView)
        view.addSubview(segmentedControl)
        view.addSubview(headerLabelStackView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }

    /// - Tag: CellRegistration
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomStcokListCellCollectionViewCell, Stock> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = [.disclosureIndicator()]
        }

        dataSource = UICollectionViewDiffableDataSource<Section, Stock>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, item: Stock) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Stock.all)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func configureLayout() {
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            refreshButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),

            segmentedControl.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20),

            headerLabelStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            collectionView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension MainHomeTabControllerCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
    // MARK: - chart
import UIKit
import LightweightCharts

class NoTimeScaleViewController: UIViewController {

    private var chart: LightweightCharts!
    private var areaSeries: AreaSeries!
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }

        setupUI()
        setupData()
    }

    private func setupUI() {
        let options = ChartOptions(
            layout: LayoutOptions(backgroundColor: "#fafafa"),
            leftPriceScale: VisiblePriceScaleOptions(visible: false),
            rightPriceScale: VisiblePriceScaleOptions(visible: false),
            timeScale: TimeScaleOptions(visible: false),
            crosshair: CrosshairOptions(
                vertLine: CrosshairLineOptions(visible: false),
                horzLine: CrosshairLineOptions(visible: false)
            ),
            grid: GridOptions(
                verticalLines: GridLineOptions(color: "#fff"),
                horizontalLines: GridLineOptions(color: "#fff")
            )
        )
        let chart = LightweightCharts(options: options)
        view.addSubview(chart)
        chart.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                chart.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                chart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                chart.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                chart.topAnchor.constraint(equalTo: view.topAnchor),
                chart.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
        }
        self.chart = chart
    }

    private func setupData() {
        let areaSeriesOptions = AreaSeriesOptions(
            topColor: "rgba(76, 175, 80, 0.5)",
            bottomColor: "rgba(76, 175, 80, 0)",
            lineColor: "rgba(76, 175, 80, 1)",
            lineWidth: .two
        )
        let areaSeries = chart.addAreaSeries(options: areaSeriesOptions)
        let areaData = [
            SingleValueData(time: .string("2018-10-19"), value: 219.31),
            SingleValueData(time: .string("2018-10-22"), value: 220.65),
            SingleValueData(time: .string("2018-10-23"), value: 222.73),
            SingleValueData(time: .string("2018-10-24"), value: 215.09),
            SingleValueData(time: .string("2018-10-25"), value: 219.80),
            SingleValueData(time: .string("2018-10-26"), value: 216.30),
            SingleValueData(time: .string("2018-10-29"), value: 212.24),
            SingleValueData(time: .string("2018-10-30"), value: 213.30),
            SingleValueData(time: .string("2018-10-31"), value: 218.86),
            SingleValueData(time: .string("2018-11-01"), value: 222.22),
            SingleValueData(time: .string("2018-11-02"), value: 207.48),
            SingleValueData(time: .string("2018-11-05"), value: 201.59),
            SingleValueData(time: .string("2018-11-06"), value: 203.77),
            SingleValueData(time: .string("2018-11-07"), value: 209.95),
            SingleValueData(time: .string("2018-11-08"), value: 208.49),
            SingleValueData(time: .string("2018-11-09"), value: 204.47),
            SingleValueData(time: .string("2018-11-12"), value: 194.17),
            SingleValueData(time: .string("2018-11-13"), value: 192.23),
            SingleValueData(time: .string("2018-11-14"), value: 186.80),
            SingleValueData(time: .string("2018-11-15"), value: 191.41),
            SingleValueData(time: .string("2018-11-16"), value: 193.53),
            SingleValueData(time: .string("2018-11-19"), value: 185.86),

        ]
        areaSeries.setData(data: areaData)
        self.areaSeries = areaSeries
    }
}

//// MARK: - ChartDelegate
//extension NoTimeScaleViewController: ChartDelegate {
//
//    func didClick(onChart chart: ChartApi, parameters: MouseEventParams) {
//
//    }
//
//    func didCrosshairMove(onChart chart: ChartApi, parameters: MouseEventParams) {
//        guard case let .barPrice(price) = parameters.price(forSeries: areaSeries),
//            let time = parameters.time,
//            let point = parameters.point
//            else {
//                return
//        }
//
//        let dateString: String
//        switch time {
//        case let .businessDay(time):
//            dateString = "\(time.year)-\(time.month)-\(time.day)"
//        case let .utc(timestamp: time):
//            let date = Date(timeIntervalSince1970: TimeInterval(time))
//            dateString = dateFormatter.string(from: date)
//        }
//    }
//
//    func didVisibleTimeRangeChange(onChart chart: ChartApi, parameters: TimeRange?) {
//
//    }
//
//}
