//
//  ToggleView.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//

import Foundation
import UIKit
import SnapKit

protocol ToggleViewDelegate:AnyObject {
    
    func goToLikes(_ toggleView: ToggleView)
    func goToPlaylist(_ toggleView: ToggleView)
}

class ToggleView:UIView {
    
    weak var delegate:ToggleViewDelegate?
    
    let buttonLike = UIButton()
    let buttonPlaylist = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(buttonLike)
        addSubview(buttonPlaylist)
        createConstraints()
        createStyle ()
        
    }

    @objc func tapLikes (_ sender:UIButton) {
        
        delegate?.goToLikes(self)
      
            buttonLike.backgroundColor = .black
            buttonPlaylist.backgroundColor = .systemGray2
            
//        }
//        else {
//            sender.isSelected = true
//            buttonLike.backgroundColor = .systemGray2
//            buttonPlaylist.backgroundColor = .black
//        }
    }
    
    @objc func tapPlylist (_ sender:UIButton) {
        
        delegate?.goToPlaylist(self)
//        if sender.isSelected {
//            sender.isSelected = false
            buttonPlaylist.backgroundColor = .black
            buttonLike.backgroundColor = .systemGray2
            
//        }
//        else {
//            sender.isSelected = true
//            buttonPlaylist.backgroundColor = .systemGray2
//            buttonLike.backgroundColor = .black
//        }
    }
    
    func  createStyle () {
        
        buttonLike.backgroundColor = .systemGray2
        buttonLike.setTitle("Лайки", for: .normal)
        buttonLike.layer.cornerRadius = 10
        buttonLike.setTitleColor(.white, for: .normal)
        buttonLike.addTarget(self, action: #selector(tapLikes), for: .touchUpInside)
        
        buttonPlaylist.backgroundColor = .systemGray2
        buttonPlaylist.setTitle("Плейлисты", for: .normal)
        buttonPlaylist.layer.cornerRadius = 10
        buttonPlaylist.setTitleColor(.white, for: .normal)
        buttonPlaylist.addTarget(self, action: #selector(tapPlylist), for: .touchUpInside)
    }
    
    func createConstraints() {
        
        buttonLike.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(5)
            make.top.equalTo(self.snp.top).inset(5)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
        
        buttonPlaylist.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(180)
            make.top.equalTo(self.snp.top).inset(5)
            make.width.equalTo(150)
            make.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
