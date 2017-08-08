//
//  UserCell.swift
//  Woobly
//
//  Created by Marcin Siemaszko on 08.08.2017.
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit
import SnapKit

final class UserCell: UITableViewCell {
    
    let userNameLabel = UILabel()
    let nameLabel = UILabel()
    private var didSetupConstraints = false
    static let identifier = "userCell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userNameLabel)
        nameLabel.textAlignment = .right
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        if !didSetupConstraints {
            didSetupConstraints = true
            userNameLabel.snp.makeConstraints { make in
                make.top.equalTo(self).offset(10)
                make.height.equalTo(21)
                make.left.equalTo(self).offset(20)
                make.right.equalTo(self).offset(-20)
            }
            
            nameLabel.snp.makeConstraints { make in
                make.top.equalTo(userNameLabel.snp.bottom).offset(10)
                make.height.equalTo(21)
                make.left.equalTo(self).offset(20)
                make.right.equalTo(self).offset(-20)
            }
        }
    }
    
    func setup(with user: User) {
        nameLabel.text = "Name: \(user.firstName) \(user.lastName)"
        userNameLabel.text = "Nick: \(user.nickname)"
    }
    
    override open class var requiresConstraintBasedLayout: Bool {
        get {
            return true
        }
    }
}
