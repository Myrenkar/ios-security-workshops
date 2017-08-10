//
//  LoginViewController.swift
//
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    fileprivate let customView = LoginView()

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable, message: "Use init(frame:) instead")
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }

    override func loadView() {
        super.loadView()

        view = customView
    }

    @objc fileprivate func loginButtonClicked() {
        if validateCredentials(withEmail: customView.emailTextField.text?.lowercased(), code: customView.accessCodeTextField.text?.lowercased()) {
            do {
                let provider = try DatabaseProvider()
                try provider.prepare()
                UsersProvider.loggedInUserId = 7
                UsersProvider.accessToken = "8sgbeaz83bfi3na3irnah419ndjaie"
                let controller = ActivateViewController()
                navigationController?.pushViewController(controller, animated: true)
            } catch {
                print(error)
            }

        } else {
            let alertControlerr = UIAlertController(title: "Error", message: "wrong credentials", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertControlerr.addAction(okAction)
            navigationController?.present(alertControlerr, animated: true, completion: nil)
        }
    }

    fileprivate func validateCredentials(withEmail email: String?, code: String?) -> Bool {
        return email == "kim" && code == "xxxcode1"
    }

}
