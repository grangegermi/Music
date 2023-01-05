//
//  HeaderCollectionViewCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 21.12.22.
//

import UIKit
import SnapKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    let label = UILabel()
    static let id = "Header"
    static let kind = "HeaderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       
        addSubview(label)
        createConstraints()
        label.textColor = .white
    }

    func createConstraints(){
        
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

