//
//  CustomTextField.swift
//  autoTradingApp
//
//  Created by 서수영 on 2023/02/24.
//

import UIKit

class CustomTextField: UITextField {

    lazy var placeholderColer: UIColor = self.tintColor
    lazy var placeholderString: String = ""

    let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left

        return label
    }()

    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .white

        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(titleView)
        addSubview(underLineView)

        self.textColor = .white
        configureContraint()

        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureContraint() {
        NSLayoutConstraint.activate([
            titleView.bottomAnchor.constraint(equalTo: self.topAnchor, constant: -17),
            titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleView.heightAnchor.constraint(equalToConstant: 18),

            underLineView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 12),
            underLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    func setPlaceholder(placeholder: String, color: UIColor) {
        placeholderString = placeholder
        placeholderColer = color

        setPlaceholder()
        underLineView.backgroundColor = placeholderColer
    }

    func setPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(
            string: placeholderString,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColer]
        )
    }

    func setError() {
        self.attributedPlaceholder = NSAttributedString(
            string: self.text ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
//        underLineView.backgroundColor = .red
    }
}

extension CustomTextField {
    @objc func editingDidBegin() {
//        setPlaceholder()
        underLineView.backgroundColor = .white
    }

    @objc func editingDidEnd() {
        underLineView.backgroundColor = placeholderColer
    }
}
