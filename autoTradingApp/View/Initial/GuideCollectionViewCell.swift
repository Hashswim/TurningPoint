//
//  GuideCollectionViewCell.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill

        return stackView
    }()

    private let guideTextView: UITextView = {
        let textView = UITextView()

//        textView.textColor = .white
        textView.backgroundColor = UIColor(named: "#333743")

        return textView
    }()

    let guideIMGView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "Dashin_test_img")
        return imgView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureHierarchy()
        self.configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init")
    }

    func configureHierarchy() {
        self.contentView.backgroundColor = MySpecialColors.bgColor
        self.addSubview(containerStackView)
        containerStackView.addArrangedSubview(guideTextView)
        containerStackView.addArrangedSubview(guideIMGView)
    }

    func configureCell(test: NSMutableAttributedString) {
        self.guideTextView.attributedText = test
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            guideTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            guideTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            guideTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//            guideTextView.heightAnchor.constraint(equalToConstant: 84),

            guideIMGView.topAnchor.constraint(equalTo: guideTextView.bottomAnchor),
            guideIMGView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            guideIMGView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            guideIMGView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


