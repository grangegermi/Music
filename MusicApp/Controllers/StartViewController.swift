//
//  StartViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//


import UIKit

import SnapKit

class StartViewController: UIViewController {
    
  var buttonStart  = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonStart)
        view.backgroundColor = .orange
        buttonStart.setTitle("Начать", for: .normal)
        buttonStart.backgroundColor = .yellow
        buttonStart.setTitleColor(.black, for: .normal)
        buttonStart.layer.cornerRadius = 10
        buttonStart.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        createConstraints()
    }
    
    @objc func buttonTap(_ sender:UIButton){
        
        let vc = AuthViewController()
        
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
   
    }

    
    private func handleSignIn(success: Bool) {
        guard success else {
            return
        }
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func createConstraints(){
        
        buttonStart.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
            make.top.equalToSuperview().inset(400)
            make.left.equalToSuperview().inset(100)
        }
    }
}
