//
//  ActivateViewController.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit
import SnapKit

final class ActivateViewController: UIViewController {
    
    private let activateButton = UIButton()
    private let activatedMarkLabel = UILabel()
    private var activated = false
    private let downloader = DataDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ActivateViewController.ativated), name: NSNotification.Name(rawValue: "Activated"), object: nil)
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        let containerView = UIView()
        activateButton.setTitle("ACTIVATE", for: .normal)
        activateButton.backgroundColor = UIColor(red: 41/255, green: 102/255, blue: 150/255, alpha: 1)
        activateButton.addTarget(self, action: #selector(ActivateViewController.activateButtonTapped(_:)), for: .touchUpInside)
        containerView.addSubview(activateButton)
        
        activatedMarkLabel.font = UIFont.systemFont(ofSize: 30)
        activatedMarkLabel.textColor = .red
        activatedMarkLabel.text = "❌"
        containerView.addSubview(activatedMarkLabel)
        view.addSubview(containerView)
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        activatedMarkLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(40)
        }
        
        activateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(120)
            make.top.equalTo(activatedMarkLabel.snp.bottom).offset(40)
            make.bottom.equalTo(containerView.snp.bottom).offset(-20)
        }
        
    }
    
    func ativated() {
        activated = true
        activatedMarkLabel.text = "✔️"
        activatedMarkLabel.textColor = .green
    }
    
    func activateButtonTapped(_: UIButton) {
        if activated {
            downloadData()
        } else {
            showNotActivatedAccountError()
        }
    }
    
    func downloadData() {
        downloader.downloadData { [weak self] error in
            DispatchQueue.main.async {
                if let _ = error {
                    self?.showDownloadError()
                } else {
                    self?.showUsersView()
                }
            }
        }
    }
    
    func showUsersView() {
        guard let usersProvider = try? UsersProvider() else {
            return
        }
        let controller = UsersViewController(usersProvider: usersProvider)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func showDownloadError() {
        let alert = UIAlertController(title: "Error", message: "Data not downloaded", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showNotActivatedAccountError() {
        let alert = UIAlertController(title: "Error", message: "Account not activated", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
