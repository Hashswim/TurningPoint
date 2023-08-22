//
//  LoginView.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/01/26.
//

import UIKit

class LoginView: UIView {
    private let guideLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.text = "이베스트에서 발급받은\n appKey와 SecretKey를 입력해주세요"
        label.textColor = .systemGray
        return label
    }()

    let nameTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.setPlaceholder(placeholder: "이름을 입력하세요", color: .black)

        return tf
    }()

    let appKeyTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.setPlaceholder(placeholder: "appkey를 입력하세요", color: .black)

        return tf
    }()

    let secretKeyTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.setPlaceholder(placeholder: "secretKey를 입력하세요", color: .black)
        tf.isSecureTextEntry = true

        return tf
    }()

    var keyGuideButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .systemGray
        btn.backgroundColor = .systemGray
        btn.setTitle("appkey와 secretKey 발급받기", for: .normal)

        return btn
    }()

    var loginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.tintColor = .systemGray
        btn.backgroundColor = .systemGray
        btn.setTitle("로그인", for: .normal)

        return btn
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill

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
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(appKeyTextField)
        containerStackView.addArrangedSubview(secretKeyTextField)
        containerStackView.addArrangedSubview(keyGuideButton)
        containerStackView.addArrangedSubview(loginButton)
    }

    func configureLayout() {
        containerStackView.setCustomSpacing(70, after: guideLabel)
        containerStackView.setCustomSpacing(56, after: nameTextField)
        containerStackView.setCustomSpacing(56, after: appKeyTextField)
        containerStackView.setCustomSpacing(48, after: secretKeyTextField)
        containerStackView.setCustomSpacing(28, after: keyGuideButton)
        containerStackView.setCustomSpacing(12, after: loginButton)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),

        ])

    }
}
