//
//  MainHomeTabControllerCollectionViewController.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/03/09.
//

import UIKit
import DropDown

private let reuseIdentifier = "Cell"

private enum Section: Hashable {
    case main
}

class MainHomeTabController: UIViewController {
    let networkManager = NetworkManager()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .bold(string: "이수림", fontSize: 28)
            .regular(string: "님", fontSize: 28)
        label.textColor = .white
        return label
    }()

    private let dropDownView = DropDownView()
    private let dropDown = DropDown()

    lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dropDownView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal

        return stackView
    }()

    private let segmentedControl = mainTabSegmentedControl(items: ["내 주식", "관심주식", "트레이딩 주식"])

    private let headerStcokLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "종목명", fontSize: 12)
        label.textColor = .gray
        return label
    }()

    private let headerChartLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "차트", fontSize: 12)
        label.textColor = .gray

        return label
    }()

    private let headerPriceLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSMutableAttributedString()
            .regular(string: "현재가", fontSize: 12)
        label.textColor = .gray

        return label
    }()

    lazy var headerLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerStcokLabel, headerChartLabel, headerPriceLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = MySpecialColors.darkGray

//        stackView.layoutMargins = UIEdgeInsets(top: 18, left: 0, bottom: 0, right: 0)
//        stackView.setCustomSpacing(145, after: headerStcokLabel)
//        stackView.setCustomSpacing(88, after: headerChartLabel)

        stackView.axis = .horizontal

        return stackView
    }()

    private var dataSource: UICollectionViewDiffableDataSource<Section, Stock>! = nil
    private var collectionView: UICollectionView! = nil

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

//        navigationItem.title = "main tab"

//        segmentedControl
        configureHierarchy()
        configureDataSource()
        setUpUI()

        var idx = 0

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] timer in
            self.networkManager.getNowPrice(code: Stock.shcodeList[idx], completion: getNowPrice)

            if idx+1 == Stock.shcodeList.count {
                timer.invalidate()
            }
            idx += 1
        }
//        self.networkManager.getDateChart(code: "005930", completion: getDateChartData)
//        self.networkManager.getScaledChart(code: "005930", completion: {})

        testAPI()
    }

    func getNowPrice(name: String, code: String, price: Double, difference: Double) -> () {
//        print(name, price, difference)
        Stock.all.append(Stock(imageURL: "08.circle", code: code, name: name, dataList: [], price: price, priceDifference: difference))
        self.networkManager.getDateChart(code: code, completion: getDateChartData)

        var snapshot = dataSource.snapshot()
        snapshot.appendItems(Stock.all)
        self.dataSource?.apply(snapshot)
    }

    func getDateChartData(chartData: [Double]) -> () {
        Stock.all.last!.dataList = chartData
    }

    //DataStore 생성하면서 변경
    private func toggleIsFavorite(_ stock: Stock, _ indexPath: IndexPath) -> Bool {
        stock.isFavorite?.toggle()

        if stock.isFavorite == true {
            Stock.favorite.append(stock)
        } else {
            Stock.favorite.remove(at: indexPath.row)
        }

        var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
        snapshot.appendSections([.main])

        if self.segmentedControl.selectedSegmentIndex == 0 {
            snapshot.appendItems(Stock.all)
        } else {
            snapshot.appendItems(Stock.favorite)
        }

        self.dataSource?.apply(snapshot)

        return stock.isFavorite!
    }

    private func testAPI() {
        let manager = NetworkManager()

        manager.getStockAPITest { stock in
            DispatchQueue.main.sync {
                dump(stock)
            }
        }
    }
}


extension MainHomeTabController {
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = MySpecialColors.bgColor

        config.trailingSwipeActionsConfigurationProvider = { [weak self] indexPath in
            return self?.trailingSwipeActionsConfiguration(for: indexPath)
        }

        config.itemSeparatorHandler = { (indexPath, sectionSeparatorConfiguration) in
            var configuration = sectionSeparatorConfiguration

            configuration.bottomSeparatorInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 0)
            configuration.color = MySpecialColors.bgColor

            return configuration
        }

        return UICollectionViewCompositionalLayout.list(using: config)
    }

    //Stock 대신 DataStore를 통해 저장해놓을 class 필요
    private func trailingSwipeActionsConfiguration(for indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard let stock = dataSource.itemIdentifier(for: indexPath)
        else { return nil }

        let configuration = UISwipeActionsConfiguration(actions: [
            detailContextualAction(stock: stock, indexPath: indexPath),
            favoriteContextualAction(stock: stock, indexPath: indexPath)
        ])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }

    private func detailContextualAction(stock: Stock, indexPath: IndexPath) -> UIContextualAction {
        let detailAction = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }

            let vc = DetailViewController()
            self.navigationController?.pushViewController(vc, animated: true)

            completionHandler(true)
        }
        detailAction.image = UIImage(systemName: "info.circle.fill")
        detailAction.backgroundColor = MySpecialColors.bgColor

        return detailAction
    }

    // inout keyword 제거 후 stocks 저장하는 객체에 접근 필요
    private func favoriteContextualAction(stock: Stock, indexPath: IndexPath) -> UIContextualAction {
//        let title = stock.isFavorite! ? "Remove from Favorites" : "Add to Favorites"
        let action = UIContextualAction(style: .normal, title: title) { [weak self] _, _, completionHandler in
            guard let self = self else { return }
            completionHandler(self.toggleIsFavorite(stock, indexPath))
        }
        let name = stock.isFavorite! ?  "heart.fill" : "heart"
        action.image = UIImage(systemName: name)
        action.backgroundColor = MySpecialColors.bgColor
        return action
    }
}

extension MainHomeTabController {
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

    private func setUpUI() {
        view.backgroundColor = MySpecialColors.bgColor

        setUpDropDown()

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: NotoSansFont.bold(size: 17), NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: NotoSansFont.bold(size: 17),NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)

        segmentedControl.setWidth(72, forSegmentAt: 0)
        segmentedControl.setWidth(72, forSegmentAt: 1)
        segmentedControl.setWidth(120, forSegmentAt: 2)

        collectionView.backgroundColor = MySpecialColors.bgColor

        dropDownView.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            containerStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            dropDownView.topAnchor.constraint(equalTo: containerStackView.topAnchor, constant: 8),
            dropDownView.bottomAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: -8),
            dropDownView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor),
            dropDownView.widthAnchor.constraint(equalToConstant: 220),

            segmentedControl.topAnchor.constraint(equalTo: containerStackView.bottomAnchor, constant: 32),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            segmentedControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 17),

            headerLabelStackView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            headerLabelStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerLabelStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerLabelStackView.heightAnchor.constraint(equalToConstant: 20),

            headerStcokLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 18),
            headerStcokLabel.widthAnchor.constraint(equalToConstant: 33),

            headerChartLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 196),
            headerChartLabel.widthAnchor.constraint(equalToConstant: 22),

            headerPriceLabel.leadingAnchor.constraint(equalTo: headerLabelStackView.leadingAnchor, constant: 304),
            headerPriceLabel.widthAnchor.constraint(equalToConstant: 33),

            collectionView.topAnchor.constraint(equalTo: headerLabelStackView.bottomAnchor, constant: 4),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
}

extension MainHomeTabController {
    /// - Tag: CellRegistration
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CustomStcokListCellCollectionViewCell, Stock> { (cell, indexPath, item) in
            cell.updateWithItem(item)
            cell.accessories = []
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

    @objc
    func segmentChanged(_ sender: UISegmentedControl) {
        switch self.segmentedControl.selectedSegmentIndex {
            //기존 snapshot에서 빼는 방식으로 변경?
        case 0:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.all)

            self.dataSource?.apply(snapshot)
        case 1:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.favorite)

            self.dataSource?.apply(snapshot)
        case 2:
            var snapshot = NSDiffableDataSourceSnapshot<Section, Stock>()
            snapshot.appendSections([.main])
            snapshot.appendItems(Stock.traiding)

            self.dataSource?.apply(snapshot)
        default:
            return
        }
    }
}

extension MainHomeTabController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let stock = dataSource.itemIdentifier(for: indexPath)
        else { return }

        let vc = StockTradingViewController()
        vc.stock = stock
        self.navigationController?.pushViewController(vc, animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

