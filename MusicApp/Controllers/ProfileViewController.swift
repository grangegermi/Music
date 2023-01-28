//
//  ProfileViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import SnapKit
class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var model = UserProfile()
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.model.viewController = self
        model.getUserProfile()
        
        title = "Settings"
        
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundView = UIVieww()
        
        tableView.register(CellForSettings.self, forCellReuseIdentifier: CellForSettings.id)
        
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
                                                               style: .plain,
                                                               target: self,
                                                               action: #selector(buttonTap))]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        createConstraints()
    }
    
    @objc func buttonTap(_ sender:UIButton ) {
        
        let alert = UIAlertController(title: "Выход",
                                      message: "Вы уверены, что хотите выйти?",
                                      preferredStyle: .alert)
        alert.view.tintColor = .gray
        
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        
        alert.addAction(UIAlertAction(title: "Выход",
                                      style: .destructive,
                                      handler: { _ in
            AuthManager.shared.singOut { [weak self] exit in
                if exit {
                    DispatchQueue.main.async {
                        let navVC = UINavigationController(rootViewController: StartViewController())
                        
                        navVC.modalPresentationStyle = .fullScreen
                        self?.present(navVC, animated: true, completion: {
                            self?.navigationController?.popToRootViewController(animated: false)
                        })
                    }
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    func createConstraints() {
        tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
    
    //MARK: -DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.userModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellForSettings.id, for: indexPath) as!  CellForSettings
        
        cell.labelTitle.text = model.description[indexPath.row]
        
        cell.labelSubTitle.text = model.userModel[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundView = UIVieww()
        
    }
}

