//
//  AlbumDetailsCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 28.12.22.
//

import UIKit
import SnapKit

class PlaylistCell: UICollectionViewCell {
    
    static let id = "AlbumDetailsCell"
    
    let label = UILabel()
    let button = UIButton()
    let imageView = UIImageView()
    let labelDescription = UILabel()

    override init(frame:CGRect){
        super.init(frame:frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(label)
        contentView.addSubview(button)
        contentView.addSubview(labelDescription)
        
        let image = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        button.setImage(image, for: .normal)
        button.tintColor = .white

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

        button.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.bottom).inset(60)
            make.right.equalTo(contentView.snp.right).inset(5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        imageView.snp.makeConstraints { make in
            
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.6)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        label.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(200)
            make.top.equalTo(contentView.snp.bottom).inset(70)
        }
//        
        labelDescription.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.width.equalTo(200)
            make.top.equalTo(contentView.snp.bottom).inset(50)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
