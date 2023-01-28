//
//  ProfileModel.swift
//  MusicApp
//
//  Created by Даша Волошина on 28.01.23.
//

import Foundation

class UserProfile {
    
    weak var viewController: ProfileViewController?
    
    var userModel:[String] = [] {
        didSet {
            
            self.viewController?.tableView.reloadData()
        }
    }
    
    var description:[String] = ["Имя пользователя:","ID:", "Email:","Продукт:" ]
    
    func getUserProfile() {
        ApiCaller.sharedCaller.getUser { [weak self] result in
            
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    self?.userModel.append("\(model.display_name)")
                    self?.userModel.append("\(model.id)")
                    self?.userModel.append("\(model.email)")
                    self?.userModel.append("\(model.product)")
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
        viewController?.tableView.reloadData()
    }
}
