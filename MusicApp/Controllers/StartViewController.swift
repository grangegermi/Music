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
    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.addSubview(imageView)
        view.addSubview(buttonStart)
     
        imageView.image = UIImage(named: "spotify")
        imageView.contentMode = .scaleAspectFill
        imageView.frame = view.bounds
       
//        view.backgroundColor = .black
        buttonStart.setTitle("Начать", for: .normal)
        buttonStart.backgroundColor = .systemGreen
        buttonStart.setTitleColor(.white, for: .normal)
        buttonStart.titleLabel?.font = UIFont(name: "Noto Sans Kannada Bold", size: 20)
//        buttonStart.titleLabel?.textAlignment = .center
        buttonStart.layer.cornerRadius = 10
        buttonStart.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        createConstraints()
    }
    
    @objc func buttonTap(_ sender:UIButton){
        print("go")
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
            make.height.equalTo(60)
            make.width.equalTo(300)
            make.bottom.equalTo(view.snp.bottom).inset(100)
            make.centerX.equalTo(view.snp.centerX)
        }
        
//        imageView.snp.makeConstraints { make in
//            make.centerX.equalTo(view.snp.centerX)
////            make.centerY.equalTo(view.snp.centerY)
//            make.top.equalTo(view.snp.top).inset(100)
//            make.width.equalTo(200)
//            make.height.equalTo(200)
//        }
    }
}
