//
//  LibraryViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit

class LibraryViewController: UIViewController, UIScrollViewDelegate, ToggleViewDelegate {
  
    let likesVC = LibraryLikeVC()
    
    let playlistVC = LibraryPlaylistVC()
    
    let scrollView = UIScrollView()
    
    let toggleView = ToggleView()
    
    var contentView = UIView()
    
    let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let contentSize = CGSize(width: view.frame.width*2, height:view.frame.height)

        view = UIVieww()
        navigationController?.navigationBar.topItem?.title = "Библиотека"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(createPlaylist))
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.topItem?.titleView?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        
        view.addSubview(scrollView)
        view.addSubview(toggleView)
  
        scrollView.addSubview(contentView)
        
        scrollView.contentSize = contentSize
        scrollView.bounces = false
 
        contentView.frame.size = contentSize
        
        contentView.addSubview(stackView)

        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        
        stackView.axis = .horizontal
       
        toggleView.delegate = self

        addChildren()
        createConstraintsScrollView()
    
    }
    
    @objc func createPlaylist(_ sender:UIBarButtonItem){
        
        let alert = UIAlertController(title: "Создать",
                                      message: "Создай свой первый плейлист",
                                      preferredStyle: .alert)
        alert.view.tintColor = .gray
        alert.addTextField{ textField in
            textField.placeholder = "Плейлист..."
        }
        
    let action1 = UIAlertAction(title: "Отменить", style: .cancel)
        
    let action2 = UIAlertAction(title: "ОК", style: .default) { _ in
        guard let field = alert.textFields?.first,
              let text = field.text,
              !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        ApiCaller.sharedCaller.createUsersPlaylist(name: text) { [weak self] result  in
            DispatchQueue.main.async {
                self?.playlistVC.model.getData()
            }
           
        }
    }
        
    alert.addAction(action1)
    alert.addAction(action2)
    present(alert, animated: true)
    }

    func createConstraintsScrollView() {
   
        scrollView.snp.makeConstraints { make in
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(80)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        
        toggleView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(20)
            make.top.equalTo(view.snp.top).inset(100)
            make.width.equalTo(250)
            make.height.equalTo(60)
        }
        
        stackView.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top)
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        likesVC.view.snp.makeConstraints { make in
            make.left.equalTo(stackView.snp.left)
            make.width.equalTo(stackView.snp.width).multipliedBy(0.5)
            make.top.equalTo(stackView.snp.top)
        }

        playlistVC.view.snp.makeConstraints { make in
            make.right.equalTo(stackView.snp.right)
            make.width.equalTo(stackView.snp.width).multipliedBy(0.5)
            make.top.equalTo(stackView.snp.top)

        }
    }
    
    func addChildren() {
        
        playlistVC.willMove(toParent: self)
        addChild(playlistVC)
        stackView.addArrangedSubview(playlistVC.view)

        playlistVC.didMove(toParent: self)
      
        
        likesVC.willMove(toParent: self)
        addChild(likesVC)
        
        stackView.addArrangedSubview(likesVC.view)
        likesVC.didMove(toParent: self)
    }

    func goToLikes(_ toggleView: ToggleView) {
        
        scrollView.setContentOffset(CGPoint(x:0,
                                            y: 0),
                                    animated: true)
    }
    
    func goToPlaylist(_ toggleView: ToggleView) {
        
        scrollView.setContentOffset(CGPoint(x:view.frame.width,
                                            y: 0),
                                    animated: true)
    }
}
