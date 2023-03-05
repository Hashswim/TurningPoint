//
//  SignUp.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/02/24.
//

import UIKit

class SignUpGuideView: UIView {
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "터닝포인트 서비스를\n이용하시려면\n대신증권 계좌가\n필요합니다."
        label.textColor = .systemGray
        return label
    }()

    private let guideImageView: UIImageView = {
        var imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "daishin_test_img")
        return imgView
    }()

    var nextButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .systemGray
        btn.backgroundColor = .systemGray
        btn.setTitle("다음", for: .normal)

        return btn
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureHierarchy() {
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(guideLabel)
        containerStackView.addArrangedSubview(guideImageView)
        containerStackView.addArrangedSubview(nextButton)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),

        ])
    }
}
