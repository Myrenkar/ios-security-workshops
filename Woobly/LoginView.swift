//
//  LoginView.swift
//  Woobly
//
//  Created by Piotr Torczynski on 09/08/2017.
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit
import SnapKit

internal final class LoginView: UIView {

    internal lazy var emailTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "      Login      "
        textField.backgroundColor = .white
        return textField
    }()

    internal lazy var accessCodeTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "      Access code      "
        textField.backgroundColor = .white
        return textField
    }()

    internal lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.backgroundColor = .white
        return button
    }()

    fileprivate lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView(arrangedSubviews: [self.emailTextField, self.accessCodeTextField])
        stackView.axis = .vertical
        stackView.spacing = 16

        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupProperties()
        setupViewHierarchy()
        setupLayoutConstraints()

    }

    func setupProperties() {
        backgroundColor = UIColor.lightGray
    }

    func setupViewHierarchy() {
        [stackView, loginButton].forEach { addSubview($0) }
    }

    func setupLayoutConstraints() {

        stackView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.centerX.equalTo(snp.centerX)
            make.centerY.equalTo(snp.centerY)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(24)
            make.width.equalTo(64)
            make.height.equalTo(36)
            make.trailing.equalTo(stackView.snp.trailing)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
