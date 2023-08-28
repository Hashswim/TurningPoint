//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit

class DetailViewController: UIViewController {

    var stock: ownedStock? = nil

    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.attributedText = NSMutableAttributedString().regular(string: "삼성전자", fontSize: 17)
        label.textColor = .white

        return label
    }()

    private let stockPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.attributedText = NSMutableAttributedString().bold(string: "72,000", fontSize: 37)
        label.textColor = .white

        return label
    }()

    private let indexImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false

        return imgView
    }()

    private let stockPriceDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.attributedText = NSMutableAttributedString().regular(string: "1,100 ( 1.55% )", fontSize: 15)
        label.textColor = .blue

        return label
    }()

    private let stockVolumeDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.attributedText = NSMutableAttributedString().regular(string: "1,100 ( 1.55% )", fontSize: 15)
        label.textColor = .blue

        return label
    }()

    private let stockInfoView = StockInfoView()

    let segmentedControl = TradingSegmentedControl(items: ["차트", "매수", "매도"])
    let chartView = ChartView2()
    let transactionBuyView = TransactionView()
    let transactionSellView = TransactionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        view.backgroundColor = MySpecialColors.bgColor

        setSegmentedControl()
        setUpTransactionView()
        configureHierarchy()
        setUpUI()
        setUpNaviBar()
        configureLayout()


    }

    func setUpNaviBar() {
        self.title = "주식 상세정보"
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]

//        let name = (self.stock?.isFavorite!)! ? "heart" : "heart.fill"
//        self.navigationItem.rightBarButtonItem =
//        UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonPressed))
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .white

        let appearance = UINavigationBarAppearance()
        appearance.shadowColor = .gray
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = MySpecialColors.bgColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
    }

//    @objc
//    func favoriteButtonPressed() {
//        //toggle isFavorite property and change UIBarButtonItem Image
//    }

    func setSegmentedControl() {
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.selectedSegmentTintColor = .white

        segmentedControl.layer.cornerRadius = 10
        segmentedControl.layer.masksToBounds = true

        segmentedControl.setContentPositionAdjustment(UIOffset(horizontal: 0, vertical: -10), forSegmentType: .any, barMetrics: .default)
    }

    func setUpTransactionView() {
        transactionBuyView.countStepper.addTarget(self, action: #selector(buyTotalPriceCounting), for: .valueChanged)
        transactionBuyView.priceStepper.addTarget(self, action: #selector(buyTotalPriceCounting), for: .valueChanged)

        transactionSellView.countStepper.addTarget(self, action: #selector(sellTotalPriceCounting), for: .valueChanged)
        transactionSellView.priceStepper.addTarget(self, action: #selector(sellTotalPriceCounting), for: .valueChanged)

        transactionBuyView.transactionButton.backgroundColor = .red
        transactionBuyView.transactionButton.setAttributedTitle(NSMutableAttributedString().medium(string: "매수", fontSize: 17), for: .normal)
        transactionBuyView.transactionButton.addTarget(self, action: #selector(buyTradeTapped), for: .touchUpInside)

        transactionSellView.transactionButton.backgroundColor = .blue
        transactionSellView.transactionButton.setAttributedTitle(NSMutableAttributedString().medium(string: "매도", fontSize: 17), for: .normal)
        transactionSellView.transactionButton.addTarget(self, action: #selector(sellTradeTapped), for: .touchUpInside)
    }

    func configureHierarchy() {
        view.addSubview(stockNameLabel)
        view.addSubview(stockPriceLabel)
        view.addSubview(indexImageView)
        view.addSubview(stockPriceDifferenceLabel)
        view.addSubview(stockVolumeDifferenceLabel)

        view.addSubview(stockInfoView)
        view.addSubview(segmentedControl)
        view.addSubview(chartView)
        view.addSubview(transactionBuyView)
        view.addSubview(transactionSellView)
    }

    @objc
    func buyTotalPriceCounting() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        transactionBuyView.totalPriceLabel.attributedText =
        NSMutableAttributedString().bold(string: numberFormatter.string(from: transactionBuyView.countStepper.value * transactionBuyView.priceStepper.value as NSNumber)!, fontSize: 28)
    }

    @objc
    func sellTotalPriceCounting() {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        transactionSellView.totalPriceLabel.attributedText =
        NSMutableAttributedString().bold(string: numberFormatter.string(from: transactionSellView.countStepper.value * transactionSellView.priceStepper.value as NSNumber)!, fontSize: 28)
    }

    @objc
    func buyTradeTapped() {

    }

    @objc
    func sellTradeTapped() {

    }
    func setUpUI() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        stockNameLabel.attributedText = NSMutableAttributedString().regular(string: (stock?.name)!, fontSize: 17)
        chartView.chartData = stock!.dateChartList!
        chartView.setupData()

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        stockPriceLabel.attributedText = NSMutableAttributedString().bold(string: numberFormatter.string(from: stock!.price! as NSNumber)!, fontSize: 37)
        stockPriceDifferenceLabel.attributedText = NSMutableAttributedString()
            .regular(string: String(stock!.change!), fontSize: 15)
            .regular(string: String(format: "(%.2f%%)", stock!.priceDifference!), fontSize: 15)
        stockVolumeDifferenceLabel.attributedText = NSMutableAttributedString().regular(string: numberFormatter.string(from: stock!.volume! as NSNumber)!, fontSize: 15)

        if (stock?.priceDifference)! < 0 {
            stockPriceDifferenceLabel.textColor = MySpecialColors.detailBlue
            stockVolumeDifferenceLabel.textColor = MySpecialColors.detailBlue

            indexImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
            indexImageView.tintColor = MySpecialColors.detailBlue
        } else if (stock?.priceDifference)! > 0 {
            stockPriceDifferenceLabel.textColor = MySpecialColors.detailRed
            stockVolumeDifferenceLabel.textColor = MySpecialColors.detailRed

            indexImageView.image = UIImage(systemName: "arrowtriangle.up.fill")
            indexImageView.tintColor = MySpecialColors.detailRed
        } else {
            stockPriceDifferenceLabel.textColor = .white
            stockVolumeDifferenceLabel.textColor = .white

            indexImageView.image = UIImage()
        }

        stockInfoView.countLabel.attributedText = NSMutableAttributedString()
            .regular(string: numberFormatter.string(from: stock!.janqty! as NSNumber)!, fontSize: 20)
            .regular(string: " 주", fontSize: 20)
        stockInfoView.priceLabel.attributedText = NSMutableAttributedString()
            .regular(string: numberFormatter.string(from: stock!.appamt! as NSNumber)!, fontSize: 20)
            .regular(string: " 원", fontSize: 20)
        stockInfoView.earningPriceLabel.attributedText = NSMutableAttributedString()
            .regular(string: numberFormatter.string(from: stock!.dtsunik! as NSNumber)!, fontSize: 20)
            .regular(string: " 원", fontSize: 20)

        if stock!.sunikrt! > 0 {
            stockInfoView.earningRateLabel.attributedText = NSMutableAttributedString()
                .regular(string: String(format: "+%.2f%%", stock!.sunikrt!), fontSize: 20)
        } else {
            stockInfoView.earningRateLabel.attributedText = NSMutableAttributedString()
                .regular(string: String(format: "%.2f%%", stock!.sunikrt!), fontSize: 20)
        }
    }

    func configureLayout() {

        stockInfoView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        transactionBuyView.translatesAutoresizingMaskIntoConstraints = false
        transactionSellView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            stockNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stockNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 200),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 17),

            stockPriceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 10),
            stockPriceLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockPriceLabel.widthAnchor.constraint(equalToConstant: 200),
            stockPriceLabel.heightAnchor.constraint(equalToConstant: 40),

//            indexImageView.topAnchor.constraint(equalTo: stockPriceLabel.topAnchor),
            indexImageView.centerYAnchor.constraint(equalTo: stockPriceDifferenceLabel.centerYAnchor),
            indexImageView.trailingAnchor.constraint(equalTo: stockPriceDifferenceLabel.leadingAnchor, constant: -4),
            indexImageView.widthAnchor.constraint(equalToConstant: 16),
            indexImageView.heightAnchor.constraint(equalToConstant: 16),

            stockPriceDifferenceLabel.topAnchor.constraint(equalTo: stockPriceLabel.topAnchor),
            stockPriceDifferenceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stockPriceDifferenceLabel.heightAnchor.constraint(equalToConstant: 22),

            stockVolumeDifferenceLabel.topAnchor.constraint(equalTo: stockPriceDifferenceLabel.bottomAnchor, constant: 2),
            stockVolumeDifferenceLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            stockVolumeDifferenceLabel.heightAnchor.constraint(equalToConstant: 18),

            stockInfoView.topAnchor.constraint(equalTo: stockPriceLabel.bottomAnchor, constant: 60),
            stockInfoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockInfoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stockInfoView.heightAnchor.constraint(equalToConstant: 100),

            segmentedControl.topAnchor.constraint(equalTo: stockInfoView.bottomAnchor, constant: 40),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            segmentedControl.widthAnchor.constraint(equalToConstant: 256),
            segmentedControl.heightAnchor.constraint(equalToConstant: 60),

            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            chartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//            chartView.heightAnchor.constraint(equalToConstant: 400),

            transactionBuyView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            transactionBuyView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transactionBuyView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            transactionBuyView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            transactionBuyView.heightAnchor.constraint(equalToConstant: 400),

            transactionSellView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            transactionSellView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            transactionSellView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            transactionSellView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

//            transactionSellView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }

    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            chartView.isHidden = false
            transactionBuyView.isHidden = true
            transactionSellView.isHidden = true

            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, .font: NotoSansFont.bold(size: 17)], for: .selected)
        case 1:
            chartView.isHidden = true
            transactionBuyView.isHidden = false
            transactionSellView.isHidden = true

            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red, .font: NotoSansFont.bold(size: 17)], for: .selected)
        case 2:
            chartView.isHidden = true
            transactionBuyView.isHidden = true
            transactionSellView.isHidden = false

            segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue, .font: NotoSansFont.bold(size: 17)], for: .selected)
        default:
            return
        }
    }

}
