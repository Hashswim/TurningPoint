//
//  DetailViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/04/11.
//

import UIKit
import DropDown

class DetailViewController: UIViewController {

    let stock: Stock? = nil
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let dropDownView = DropDownView()
    private let dropDown = DropDown()

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

    private let segmentedControl = mainTabSegmentedControl(items: ["차트", "호가"])

    private let chartView = ChartView2()
    private let transactionView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = MySpecialColors.bgColor

        setUpNaviBar()
        setUpDropDown()
        setUpUI()
        configureLayout()
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

    func setUpUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(dropDownView)
        contentView.addSubview(stockNameLabel)
        contentView.addSubview(stockPriceLabel)
        contentView.addSubview(stockInfoView)
        contentView.addSubview(segmentedControl)
        contentView.addSubview(chartView)
        contentView.addSubview(transactionView)

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }

    func configureLayout() {
        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        stockInfoView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        transactionView.translatesAutoresizingMaskIntoConstraints = false

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
            dropDownView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            dropDownView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -4),
            dropDownView.heightAnchor.constraint(equalToConstant: 36),

            stockNameLabel.topAnchor.constraint(equalTo: dropDownView.bottomAnchor, constant: 4),
            stockNameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockNameLabel.widthAnchor.constraint(equalToConstant: 200),
            stockNameLabel.heightAnchor.constraint(equalToConstant: 20),

            stockPriceLabel.topAnchor.constraint(equalTo: stockNameLabel.bottomAnchor),
            stockPriceLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockPriceLabel.widthAnchor.constraint(equalToConstant: 200),
            stockPriceLabel.heightAnchor.constraint(equalToConstant: 20),

            stockInfoView.topAnchor.constraint(equalTo: stockPriceLabel.bottomAnchor),
            stockInfoView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stockInfoView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stockInfoView.heightAnchor.constraint(equalToConstant: 280),

            segmentedControl.topAnchor.constraint(equalTo: stockInfoView.bottomAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 20),

            chartView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            chartView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            chartView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            chartView.heightAnchor.constraint(equalToConstant: 400),

            transactionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            transactionView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            transactionView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            transactionView.heightAnchor.constraint(equalToConstant: 400),
        ])
    }

    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
        case 0:
            chartView.isHidden = false
            transactionView.isHidden = true
        case 1:
            chartView.isHidden = true
            transactionView.isHidden = false
        default:
            return
        }
    }

}
