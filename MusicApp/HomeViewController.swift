//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.title = "Home"
        
        navigationItem.rightBarButtonItems =  [UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(buttonTap)),
 UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(buttonTap))]

       
     
    }
 
    @objc func buttonTap(_ sender:UIButton){
        
        let vc = ProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
    }

   

}

