//
//  DropDownView.swift
//  autoTradingApp
//
////  Created by 서수영 on 2023/06/22.
////
//
import UIKit

class DropDownView: UIView {

    let dropDownBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false

        return btn
    }()

    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isEnabled = false
        textField.textColor = MySpecialColors.dropGray
        textField.attributedText = NSMutableAttributedString().regular(string: "모든 거래", fontSize: 12)
        return textField
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "arrowtriangle.down.fill")
        imageView.tintColor = MySpecialColors.dropGray

        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(dropDownBtn)
        addSubview(textField)
        addSubview(imageView)

        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
    }

    private func configureLayout() {

        NSLayoutConstraint.activate([
            dropDownBtn.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            dropDownBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            dropDownBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            dropDownBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),

            textField.widthAnchor.constraint(equalToConstant: 180),
            textField.heightAnchor.constraint(equalToConstant: 17),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 4),
            textField.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),

            imageView.widthAnchor.constraint(equalToConstant: 12),
            imageView.heightAnchor.constraint(equalToConstant: 8),
            imageView.centerYAnchor.constraint(equalTo: textField.centerYAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -4),
        ])
    }
}
