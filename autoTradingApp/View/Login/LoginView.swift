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
        label.attributedText = NSMutableAttributedString()
            .regular(string: "이베스트에서 발급받은\n", fontSize: 22)
            .bold(string: "정보를 입력해주세요", fontSize: 28)
        label.textColor = .white
        return label
    }()

    let nameTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.titleView.attributedText = NSMutableAttributedString().medium(string: "이름", fontSize: 13)
        tf.setPlaceholder(placeholder: "이름을 입력해주세요", color: MySpecialColors.holderGray)

        return tf
    }()

    let appKeyTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.titleView.attributedText = NSMutableAttributedString().medium(string: "App Key", fontSize: 13)
        tf.setPlaceholder(placeholder: "App Key를 입력해주세요", color: MySpecialColors.holderGray)

        return tf
    }()

    let secretKeyTextField: UITextField = {
        let tf = CustomTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.tintColor = .black
        tf.titleView.attributedText = NSMutableAttributedString().medium(string: "Secret Key", fontSize: 13)
        tf.setPlaceholder(placeholder: "Secret Key를 입력해주세요", color: MySpecialColors.holderGray)

        return tf
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let imageAttachment = NSTextAttachment()
        let exclamationmarkImage = UIImage(systemName: "exclamationmark.circle")
        let image = exclamationmarkImage!.withTintColor(MySpecialColors.lightRed2, renderingMode: .alwaysTemplate)
        imageAttachment.image = image
        imageAttachment.bounds = CGRect(x: 0, y: 0, width: 13, height: 13)

        let attributedString = NSMutableAttributedString(string: "")
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSMutableAttributedString().regular(string: " Key 정보가 유효하지 않습니다. 다시 입력해주세요.", fontSize: 13))
        label.attributedText = attributedString

        label.textColor = MySpecialColors.lightRed2
        label.textAlignment = .right
        label.isHidden = true
        return label
    }()

    var keyGuideButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 10
        btn.tintColor = .systemGray
        btn.backgroundColor = .systemGray
        btn.setTitle("Key 발급받기", for: .normal)

        return btn
    }()

    var loginButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.masksToBounds = true
        btn.layer.borderColor = UIColor.systemGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 10
//        btn.tintColor = .systemGray
        btn.backgroundColor = MySpecialColors.bgColor
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
        containerStackView.addArrangedSubview(errorLabel)
        containerStackView.addArrangedSubview(keyGuideButton)
        containerStackView.addArrangedSubview(loginButton)
    }

    func configureLayout() {
        containerStackView.setCustomSpacing(80, after: guideLabel)
        containerStackView.setCustomSpacing(88, after: nameTextField)
        containerStackView.setCustomSpacing(56, after: appKeyTextField)
        containerStackView.setCustomSpacing(72, after: secretKeyTextField)
        containerStackView.setCustomSpacing(12, after: errorLabel)
        containerStackView.setCustomSpacing(16, after: keyGuideButton)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 18),
            containerStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -18),

            keyGuideButton.heightAnchor.constraint(equalToConstant: 60),
            loginButton.heightAnchor.constraint(equalToConstant: 60),
        ])

    }
}
