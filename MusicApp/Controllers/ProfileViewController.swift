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
       
        some()
    }
    func some() {
        ApiCaller.sharedCaller.getUser { [weak self] result in
            DispatchQueue.main.async {
                
                switch result{
                    
                case .success(let model):
                    self?.userModel.append("UserName: \(model.display_name)")
                    self?.userModel.append("ID: \(model.id)")
                    self?.userModel.append("Email: \(model.email)")
                    self?.userModel.append("Product: \(model.product)")
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
                default: break
                    
                }

            }
        }
    }
//    func createUserModel () {
////
//        tableView.reloadData()
//    }
    
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

