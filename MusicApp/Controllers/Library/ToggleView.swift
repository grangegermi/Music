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

class ToggleView:UIView{
    
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
    }
    
    @objc func tapPlylist (_ sender:UIButton) {
        
        delegate?.goToPlaylist(self)
    }
    
    func  createStyle () {
        
        buttonLike.backgroundColor = .lightGray
        buttonLike.setTitle("Likes", for: .normal)
        buttonLike.layer.cornerRadius = 10
        buttonLike.setTitleColor(.white, for: .normal)
        buttonLike.addTarget(self, action: #selector(tapLikes), for: .touchUpInside)
        
        buttonPlaylist.backgroundColor = .lightGray
        buttonPlaylist.setTitle("Playlist", for: .normal)
        buttonPlaylist.layer.cornerRadius = 10
        buttonPlaylist.setTitleColor(.white, for: .normal)
        buttonPlaylist.addTarget(self, action: #selector(tapPlylist), for: .touchUpInside)
    }
    
    func createConstraints() {
        
        buttonLike.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(5)
            make.top.equalTo(self.snp.top).inset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        buttonPlaylist.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).inset(120)
            make.top.equalTo(self.snp.top).inset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}