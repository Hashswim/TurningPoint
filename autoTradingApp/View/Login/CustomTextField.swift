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

    private lazy var underLineView: UIView = {
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = .white

        return lineView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(underLineView)
        configureContraint()

        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureContraint() {
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalTo: self.bottomAnchor),
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
            string: placeholderString,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red]
        )
        underLineView.backgroundColor = .red
    }
}

extension CustomTextField {
    @objc func editingDidBegin() {
        setPlaceholder()
        underLineView.backgroundColor = self.tintColor
    }

    @objc func editingDidEnd() {
        underLineView.backgroundColor = placeholderColer
    }
}
