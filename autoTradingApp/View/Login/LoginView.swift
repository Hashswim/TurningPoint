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

    let loginTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "이메일 주소 입력"
        return tf
    }()

    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "비밀번호 ()자리 이상 입력"
        tf.isSecureTextEntry = true
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
        btn.tintColor = .black
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
        containerStackView.addArrangedSubview(loginTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(passwordGuideContainerStackView)

        passwordGuideContainerStackView.addArrangedSubview(passwordGuideLabel)
        passwordGuideContainerStackView.addArrangedSubview(passwordGuideButton)
    }

    func configureLayout() {
        NSLayoutConstraint.activate([

        ])

    }
}
