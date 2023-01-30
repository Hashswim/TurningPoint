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
        label.text = "너도 주식 할 수 있어\n클릭 한번 자동으로"
        label.textColor = .systemGray
        return label
    }()

    private let loginTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "이메일 주소 입력"
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "비밀번호 ()자리 이상 입력"
        return tf
    }()

    private let passwordGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 잊으셨다면"
        return label
    }()

    private let passwordGuideButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 재설정", for: .normal)
        return btn
    }()

    private let passwordGuideContainerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        return stackView
    }()

    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
        containerStackView.addArrangedSubview(loginTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(passwordGuideContainerStackView)

        passwordGuideContainerStackView.addArrangedSubview(passwordGuideLabel)
        passwordGuideContainerStackView.addArrangedSubview(passwordGuideButton)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([
            guideLabel.topAnchor.constraint(equalTo: self.topAnchor),
            guideLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            guideLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            guideLabel.heightAnchor.constraint(equalToConstant: 70),

            loginTextField.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 16),
            loginTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            loginTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            loginTextField.heightAnchor.constraint(equalToConstant: 20),

            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16),
            passwordTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),
            passwordTextField.heightAnchor.constraint(equalToConstant: 20),

            passwordGuideContainerStackView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            passwordGuideContainerStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            passwordGuideContainerStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8),

            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
        ])

    }
}
