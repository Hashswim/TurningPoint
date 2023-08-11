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
            .bold(string: "이수림", fontSize: 28)
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

    private let dropDownView = DropDownView()
    private let dropDown = DropDown()

    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<TradingData, TradingTransaction>! = nil
    private var tradingData: TradingData?

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
        configureDataSource()
        updateDataSource()
    }

    private func setUpUI() {
        view.backgroundColor = MySpecialColors.bgColor
        view.addSubview(nameLabel)
        view.addSubview(nameLabel2)
        view.addSubview(dropDownView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)
        collectionView.backgroundColor = MySpecialColors.bgColor
        collectionView.isDirectionalLockEnabled = false
        collectionView.register(
            TradingCell.self,
            forCellWithReuseIdentifier: TradingCell.reuseIdentifier
        )
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: HeaderView.reuseElementKind,
            withReuseIdentifier: HeaderView.reuseIdentifier
        )
        collectionView.isDirectionalLockEnabled = true
//        collectionView.isPagingEnabled = true
        //Trading Data 등록
        tradingData = TradingData(cells: [])

        setUpDropDown()
    }

    private func configrueLayout() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 28.5),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.heightAnchor.constraint(equalToConstant: 28),

            nameLabel2.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel2.heightAnchor.constraint(equalToConstant: 28),

            dropDownView.topAnchor.constraint(equalTo: nameLabel2.bottomAnchor, constant: 26.5),
            dropDownView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            dropDownView.heightAnchor.constraint(equalToConstant: 32),
            dropDownView.widthAnchor.constraint(equalToConstant: 220),

            collectionView.topAnchor.constraint(equalTo: dropDownView.bottomAnchor, constant: 16.9),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
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

extension TradingViewController {
    private func createLayout() -> UICollectionViewLayout {
        // Sticky column
        let stickyHeaderSize = NSCollectionLayoutSize(
            widthDimension: .absolute(89 * 50),
            heightDimension: .absolute(30)
        )
        
        let stickyHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: stickyHeaderSize,
            elementKind: HeaderView.reuseElementKind,
            alignment: .top,
            absoluteOffset: CGPoint(x: 0, y: 0)
        )
        stickyHeader.pinToVisibleBounds = true

        // Item cell
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(89 * 5),
            heightDimension: .absolute(32)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(89 * 5),
                heightDimension: .absolute(32 * 10)
            )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                     subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
//        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = [stickyHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

        return UICollectionViewCompositionalLayout(section: section)
    }

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<TradingData, TradingTransaction>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, data: TradingTransaction) -> UICollectionViewCell? in
            // Return the cell.
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TradingCell.reuseIdentifier, for: indexPath) as? TradingCell else {
                return nil
            }
            cell.dateLabel.attributedText =  NSMutableAttributedString().regular(string: "\(data.cells[0])", fontSize: 12)
            cell.actionLabel.attributedText = NSMutableAttributedString().regular(string: "\(data.cells[1])", fontSize: 12)
            cell.priceLabel.attributedText = NSMutableAttributedString().regular(string: "\(data.cells[2])", fontSize: 12)
            cell.investmentLabel.attributedText = NSMutableAttributedString().regular(string: "\(data.cells[3])", fontSize: 12)
            cell.balanceLabel.attributedText = NSMutableAttributedString().regular(string: "\(data.cells[4])", fontSize: 12)

            return cell
        }

        dataSource.supplementaryViewProvider = {(
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath
        ) -> UICollectionReusableView? in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: HeaderView.reuseElementKind,
                withReuseIdentifier: HeaderView.reuseIdentifier,
                for: indexPath
            ) as? HeaderView else {
                fatalError("Cannot create new supplementary")
            }
//            headerView.label.text = "99999"
            return headerView
        }
    }

    func updateDataSource() {
        guard let tradingData = tradingData else { return }
        var snapshot = NSDiffableDataSourceSnapshot<TradingData, TradingTransaction>()
        snapshot.appendSections([tradingData])
        snapshot.appendItems(tradingData.transactions)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

