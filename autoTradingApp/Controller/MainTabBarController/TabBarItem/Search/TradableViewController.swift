//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit
import DropDown

class TradableViewController: UIViewController {

    let stock: Stock? = nil
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dropDownView = DropDownView()
    private let dropDown = DropDown()

    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString().regular(string: "삼성전자", fontSize: 17)
        label.textColor = .white

        return label
    }()

    private let stockPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString().bold(string: "72,000", fontSize: 37)
        label.textColor = .white

        return label
    }()

    private let indexImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        var image = UIImage(systemName: "arrowtriangle.down.fill")
        image!.withTintColor(.blue)
        imgView.image = image

        return imgView
    }()

    private let stockPriceDifferenceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString().regular(string: "1,100 ( 1.55% )", fontSize: 15)
        label.textColor = .blue

        return label
    }()

    private let segmentedControl = mainTabSegmentedControl(items: ["차트", "매수", "매도"])

    private let chartView = ChartView2()
    private let transactionBuyView = TransactionView()
    private let transactionSellView = TransactionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MySpecialColors.bgColor

        setUpNaviBar()
        setUpDropDown()
        setSegmentedControl()
        setUpUI()
        configureLayout()

        transactionBuyView.isHidden = true
        transactionSellView.isHidden = true

    }

    func setUpNaviBar() {
        self.title = "주식 상세정보"

//        let name = (self.stock?.isFavorite!)! ? "heart" : "heart.fill"
        self.navigationItem.rightBarButtonItem =
        UIBarButtonItem(image: UIImage(systemName: "heart.fill"), style: .plain, target: self, action: #selector(favoriteButtonPressed))
    }

    private func setUpDropDown() {
        dropDownView.dropDownBtn.addTarget(self, action: #selector(dropdownClicked), for: .touchUpInside)
        dropDownView.translatesAutoresizingMaskIntoConstraints = false

        let itemList = ["item1", "item2", "item3", "item4", "item5", "item6"]

        dropDown.dataSource = itemList
        dropDownView.backgroundColor = MySpecialColors.borderGray

        DropDown.appearance().textColor = UIColor.black // 아이템 텍스트 색상
        DropDown.appearance().selectedTextColor = UIColor.red // 선택된 아이템 텍스트 색상
        DropDown.appearance().backgroundColor = UIColor.white // 아이템 팝업 배경 색상
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray // 선택한 아이템 배경 색상
        DropDown.appearance().setupCornerRadius(8)
        dropDown.dismissMode = .automatic // 팝업을 닫을 모드 설정

        dropDown.anchorView = self.dropDownView

        // View를 갖리지 않고 View아래에 Item 팝업이 붙도록 설정
        dropDown.bottomOffset = CGPoint(x: 0, y: 36)

        // Item 선택 시 처리
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.dropDownView.textField.attributedText = NSMutableAttributedString().regular(string: item, fontSize: 12)
            self!.dropDownView.imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
        // 취소 시 처리
        dropDown.cancelAction = { [weak self] in
            self!.dropDownView.imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        }
    }

    @objc
    func dropdownClicked(_ sender: Any) {
        dropDown.show()
        self.dropDownView.imageView.image = UIImage(systemName: "arrowtriangle.up.fill")

    }

    @objc
    func favoriteButtonPressed() {
        //toggle isFavorite property and change UIBarButtonItem Image
    }

    func setSegmentedControl() {
        segmentedControl.backgroundColor = .lightGray
        segmentedControl.selectedSegmentTintColor = .white

        segmentedControl.layer.cornerRadius = 10
        segmentedControl.layer.masksToBounds = true

        segmentedControl.setContentPositionAdjustment(UIOffset(horizontal: 0, vertical: -10), forSegmentType: .any, barMetrics: .default)
    }

    func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dropDownView)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(stockPriceLabel)
        contentView.addSubview(indexImageView)
        contentView.addSubview(stockPriceDifferenceLabel)
        
        contentView.addSubview(segmentedControl)
        contentView.addSubview(chartView)
        contentView.addSubview(transactionBuyView)
        contentView.addSubview(transactionSellView)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    func configureLayout() {
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        transactionBuyView.translatesAutoresizingMaskIntoConstraints = false
        transactionSellView.translatesAutoresizingMaskIntoConstraints = false

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

            dropDownView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            dropDownView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            dropDownView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            dropDownView.heightAnchor.constraint(equalToConstant: 36),

            stockNameLabel.topAnchor.constraint(equalTo: dropDownView.bottomAnchor, constant: 52),
            stockNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 200),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 17),

            stockPriceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor, constant: 10),
            stockPriceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockPriceLabel.widthAnchor.constraint(equalToConstant: 200),
            stockPriceLabel.heightAnchor.constraint(equalToConstant: 40),

            stockPriceDifferenceLabel.topAnchor.constraint(equalTo: stockPriceLabel.topAnchor),
            stockPriceDifferenceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            stockPriceDifferenceLabel.heightAnchor.constraint(equalToConstant: 24),

            indexImageView.topAnchor.constraint(equalTo: stockPriceLabel.topAnchor),
            indexImageView.trailingAnchor.constraint(equalTo: stockPriceDifferenceLabel.leadingAnchor, constant: -4),
            indexImageView.widthAnchor.constraint(equalToConstant: 20),
            indexImageView.heightAnchor.constraint(equalToConstant: 20),

            segmentedControl.topAnchor.constraint(equalTo: stockPriceLabel.bottomAnchor, constant: 84),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            segmentedControl.widthAnchor.constraint(equalToConstant: 256),
            segmentedControl.heightAnchor.constraint(equalToConstant: 60),

            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            chartView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            chartView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            chartView.heightAnchor.constraint(equalToConstant: 400),

            transactionBuyView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            transactionBuyView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            transactionBuyView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            transactionBuyView.heightAnchor.constraint(equalToConstant: 400),

            transactionSellView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: -20),
            transactionSellView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            transactionSellView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            transactionSellView.heightAnchor.constraint(equalToConstant: 400),
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
