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
        label.text = "이메일과 비밀번호를\n입력하세요"
        label.textColor = .systemGray
        return label
    }()

    let idTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.setPlaceholder(placeholder: "id를 입력하세요", color: .black)

        return tf
    }()

    let passwordTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.setPlaceholder(placeholder: "비밀번호를 입력하세요", color: .black)
        tf.isSecureTextEntry = true

        return tf
    }()

    private let passwordGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호를 잊으셨다면 비밀번호 재설정"
        return label
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
        containerStackView.addArrangedSubview(idTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(passwordGuideLabel)
        containerStackView.addArrangedSubview(loginButton)
    }

    func configureLayout() {
        containerStackView.setCustomSpacing(70, after: guideLabel)
        containerStackView.setCustomSpacing(56, after: idTextField)
        containerStackView.setCustomSpacing(48, after: passwordTextField)
        containerStackView.setCustomSpacing(28, after: passwordGuideLabel)
        containerStackView.setCustomSpacing(12, after: loginButton)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),

        ])

    }
}
