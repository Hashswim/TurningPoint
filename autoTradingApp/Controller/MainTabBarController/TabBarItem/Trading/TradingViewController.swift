//
//  TradingViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/05/22.
//

import UIKit
import DropDown

class TradingViewController: UIViewController {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString()
            .bold(string: UserInfo.shared.name ?? "ddd", fontSize: 28)
            .regular(string: "님", fontSize: 28)
        label.textColor = .white
        return label
    }()

    private let nameLabel2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = NSMutableAttributedString()
            .regular(string: "트레이딩 상세정보", fontSize: 28)
        label.textColor = .white
        return label
    }()

    private let transactionButton = TransactionButton()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = MySpecialColors.bgColor
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 8

        return stackView
    }()

    private let dropDownView = DropDownView()
    private let dropDown = DropDown()

    private let headerDateLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "Date", fontSize: 13)
        label.textColor = .gray
        return label
    }()

    private let headerPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "Price", fontSize: 13)
        label.textColor = .gray

        return label
    }()

    private let headerActionLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "Action", fontSize: 13)
        label.textColor = .gray

        return label
    }()

    private let headerInvestmentLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "Investment", fontSize: 13)
        label.textColor = .gray

        return label
    }()

    lazy var headerLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerDateLabel, headerPriceLabel, headerActionLabel, headerInvestmentLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = MySpecialColors.darkGray

        stackView.axis = .horizontal

        return stackView
    }()

    private var tableView = UITableView()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        configrueLayout()
        configureTableView()
    }

    private func setUpUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        transactionButton.translatesAutoresizingMaskIntoConstraints = false

        view.backgroundColor = MySpecialColors.bgColor

        containerStackView.addArrangedSubview(nameLabel2)
        containerStackView.addArrangedSubview(transactionButton)
        containerStackView.backgroundColor = MySpecialColors.bgColor

        view.addSubview(nameLabel)
        view.addSubview(containerStackView)
        view.addSubview(dropDownView)
        view.addSubview(headerLabelStackView)
        view.addSubview(tableView)

        setUpDropDown()
    }

    private func configrueLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28.5),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 34),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),

            containerStackView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
//            containerStackView.heightAnchor.constraint(equalToConstant: 58),

            nameLabel2.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 18),
            nameLabel2.heightAnchor.constraint(equalToConstant: 28),

            transactionButton.topAnchor.constraint(equalTo: nameLabel2.bottomAnchor, constant: 21),
            transactionButton.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor),
            transactionButton.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            transactionButton.heightAnchor.constraint(equalToConstant: 52),

            dropDownView.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 50),
            dropDownView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            dropDownView.heightAnchor.constraint(equalToConstant: 32),
            dropDownView.widthAnchor.constraint(equalToConstant: 220),

            headerLabelStackView.topAnchor.constraint(equalTo: dropDownView.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            headerDateLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 34),
            headerDateLabel.widthAnchor.constraint(equalToConstant: 29),

            headerPriceLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 135),
            headerPriceLabel.widthAnchor.constraint(equalToConstant: 31),

            headerActionLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 218),
            headerActionLabel.widthAnchor.constraint(equalToConstant: 40),

            headerInvestmentLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 288),
            headerInvestmentLabel.widthAnchor.constraint(equalToConstant: 30),

            tableView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 2),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.backgroundColor = MySpecialColors.bgColor

        tableView.register(TradingCell.self, forCellReuseIdentifier: TradingCell.cellID)
    }
}

extension TradingViewController {
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
}

extension TradingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TradingTransaction.all.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TradingCell.cellID, for: indexPath) as! TradingCell

        cell.dateLabel.attributedText = NSMutableAttributedString()
            .regular(string: TradingTransaction.all[indexPath.row].date, fontSize: 12)

        cell.priceLabel.attributedText = NSMutableAttributedString()
            .regular(string: String(TradingTransaction.all[indexPath.row].price), fontSize: 12)

        cell.actionLabel.attributedText = NSMutableAttributedString()
            .regular(string: TradingTransaction.all[indexPath.row].action + "\(TradingTransaction.all[indexPath.row].count)", fontSize: 12)

        cell.investmentLabel.attributedText = NSMutableAttributedString()
            .regular(string: String(TradingTransaction.all[indexPath.row].investment) + "%", fontSize: 12)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 32
    }
}
