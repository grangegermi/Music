//
//  CategoryCellDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 25.01.23.
//

import UIKit

class CategoryCellDetails: UICollectionViewCell {
    
        static let id = "CategoryCellDetails"
        
        let imageView = UIImageView()
        let namePlaylist = UILabel()
        let nameArtist = UILabel()
     
        override init(frame:CGRect){
            super.init(frame:frame)
            
            contentView.addSubview(imageView)
            contentView.addSubview(namePlaylist)
            contentView.addSubview(nameArtist)
            
            namePlaylist.font = UIFont(name: "Noto Sans Kannada Bold", size: 14)
            nameArtist.font = UIFont(name: "Noto Sans Kannada Regular", size: 12)
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 6
            imageView.layer.masksToBounds = true
            namePlaylist.numberOfLines = 0
            namePlaylist.textColor = .white
            nameArtist.numberOfLines = 0
            nameArtist.textColor = .white
            createConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
   
    func createConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(200)
        }
        
        namePlaylist.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(210)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width)
        }
        
        
        
        nameArtist.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(240)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width).inset(60)
        }
   
    }

}
