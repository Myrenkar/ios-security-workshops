//
//  UsersViewController.swift
//  Woobly
//
//  Copyright © 2017 netguru. All rights reserved.
//

import UIKit

final class UsersViewController: UITableViewController {
    
    var users: [User]? = nil
    var filteredUsers: [User]? = nil
    var usersProvider: UsersProvider
    let searchController = UISearchController(searchResultsController: nil)
    
    init(usersProvider: UsersProvider) {
        self.usersProvider = usersProvider
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UserCell.self, forCellReuseIdentifier: UserCell.identifier)
        setupSearchController()
        usersProvider.all { [weak self] users in
            self?.users = users
            self?.tableView.reloadData()
        }
        
        usersProvider.loggedInUserId = 7
        if usersProvider.loggedInUser?.role == "admin" {
            let barButton = UIBarButtonItem(title: "Admin", style: .done, target: nil, action: nil)
            navigationItem.rightBarButtonItem = barButton
        }
        
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
    }
    
}

extension UsersViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? filteredUsers?.count ?? 0 : users?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as? UserCell else {
                
            return UITableViewCell()
        }
        
        if let user = searchController.isActive ? filteredUsers?[indexPath.row] : users?[indexPath.row] {
            cell.setup(with: user)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

extension UsersViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        guard searchController.isActive else {
            filteredUsers = nil
            tableView.reloadData()
            return
        }
        
        usersProvider.find(text: text) { [weak self] users in
            self?.filteredUsers = users
            self?.tableView.reloadData()
        }
        
    }
}
