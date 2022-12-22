//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var tableView = UITableView()
    
    var userModel = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(CellForSettings.self, forCellReuseIdentifier: CellForSettings.id)
        
        createConstraints()
        createUserModel()

    }
    
    func createUserModel () {
        userModel.append("UserName: \(ApiCaller.sharedCaller.result.display_name)")
        userModel.append("ID: \(ApiCaller.sharedCaller.result.id)")
        userModel.append("Email: \(ApiCaller.sharedCaller.result.email)")
        userModel.append("Product: \(ApiCaller.sharedCaller.result.product)")
        tableView.reloadData()
    }
    
    func createConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellForSettings.id, for: indexPath) as!  CellForSettings
       
        cell.labelTitle.text = userModel[indexPath.row]
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

