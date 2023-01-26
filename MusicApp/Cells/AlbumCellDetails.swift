//
//  AlbumCellDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 1.01.23.
//

import UIKit
import SnapKit

class AlbumCellDetails: UICollectionViewCell {
 
    static let id = "AlbumCellDetails"

    let label = UILabel()
    let imageView = UIImageView()
    let labelDescription = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
      
        contentView.addSubview(imageView)
        contentView.addSubview(labelDescription)
       
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
  
        label.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        label.textColor = .white
        labelDescription.font = UIFont(name: "Noto Sans Kannada Regular", size: 14)
        labelDescription.numberOfLines = 0
        labelDescription.textColor = .white
        
        createConstraints()
        
    }

    func createConstraints() {
        
        imageView.snp.makeConstraints { make in
            
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(200)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
            make.top.equalTo(contentView.snp.top).inset(230)
        }
        
        labelDescription.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(100)
            make.top.equalTo(contentView.snp.top).inset(210)
            make.right.equalTo(contentView.snp.right).inset(-30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
