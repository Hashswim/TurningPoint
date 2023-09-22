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
        stackView.spacing = 54

        return stackView
    }()

    private let guideTextView: UITextView = {
        let textView = UITextView()

        textView.textAlignment = .center
        textView.backgroundColor = UIColor(hex: "#181C26")

        return textView
    }()

    let guideIMGView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
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
        self.contentView.backgroundColor = UIColor(hex: "#181C26")
        self.addSubview(containerStackView)
        containerStackView.addArrangedSubview(guideTextView)
        containerStackView.addArrangedSubview(guideIMGView)
    }

    func configureCell(test: NSMutableAttributedString, img: UIImage) {
        self.guideTextView.attributedText = test
        self.guideIMGView.image = img
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            guideTextView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 28),
            guideTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 63.49),
            guideTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -63.49),
            guideTextView.heightAnchor.constraint(equalToConstant: 54),

            guideIMGView.topAnchor.constraint(equalTo: guideTextView.bottomAnchor, constant: 54),
            guideIMGView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            guideIMGView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            guideIMGView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}


