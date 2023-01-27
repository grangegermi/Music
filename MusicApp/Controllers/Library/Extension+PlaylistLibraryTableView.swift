//
//  Extension+PlaylistLibraryTableView.swift
//  MusicApp
//
//  Created by Даша Волошина on 27.01.23.
//

import Foundation
import UIKit

extension UITableView{
    
    func emptyView(title:String, message:String) {
    
        var emptyView = UIView()
        var titleLabel = UILabel()
        var messageLabel = UILabel()
      
        emptyView.frame = CGRect(x: self.center.x,
                                 y: self.center.y,
                                 width: self.bounds.size.width,
                                 height: self.bounds.size.height)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        emptyView.backgroundColor = .gray
     
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.top.equalTo(emptyView.snp.top).inset(120)
            
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(emptyView.snp.centerX)
            make.width.equalTo(200)
            make.height.equalTo(200)
            make.top.equalTo(emptyView.snp.top).inset(200)
            
        }
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "Noto Sans Kannada Bold", size: 18)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        messageLabel.textColor = .white
        messageLabel .textAlignment = .center
        
        titleLabel.text = title
        messageLabel.text = message

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
