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
//    private var dataSource: UICollectionViewDiffableDataSource<SectionData, CellData>! = nil

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
    }

    private func setUpUI() {
        view.backgroundColor = MySpecialColors.bgColor
        view.addSubview(nameLabel)
        view.addSubview(nameLabel2)
        view.addSubview(dropDownView)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(collectionView)

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
    private func createLayout() -> UICollectionViewLayout  {
        // Sticky column
//        let stickyColumnCellSize = NSCollectionLayoutSize(
//            widthDimension: .absolute(cellWidth),
//            heightDimension: .absolute(columnHeight)
//        )
//        let stickyColumn = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: stickyColumnCellSize,
//            elementKind: stickyColumnElementKind,
//            alignment: .leading,
//            absoluteOffset: CGPoint(x: -cellWidth, y: 0)
//        )
//        stickyColumn.pinToVisibleBounds = true
//        stickyColumn.zIndex = 2

        // Item cell
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(88),
            heightDimension: .absolute(32)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        var groups: [NSCollectionLayoutGroup] = []
        for _ in 0..<5 {
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: itemSize,
                subitems: [item]
            )
            groups.append(group)
        }

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(88*5),
            heightDimension: .absolute(32)
        )
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: groups
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
//        section.boundarySupplementaryItems = [stickyColumn]
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: cellWidth, bottom: 0, trailing: 0)

        return UICollectionViewCompositionalLayout(section: section)
    }

    
}




