//
//  RecomendationCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 21.12.22.
//

import UIKit

class RecomendationCell: UICollectionViewCell {
    
    static let id = "Recomendation"
   
    let imageView = UIImageView()
    let namePlaylist = UILabel()
    let nameArtist = UILabel()
   
  
    override init(frame:CGRect){
        super.init(frame:frame)
    
        contentView.addSubview(imageView)
        contentView.addSubview(namePlaylist)
        contentView.addSubview(nameArtist)
        

        imageView.contentMode = .scaleAspectFill
        createConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints() {
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(80)
        }
        
        namePlaylist.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).inset(10)
            make.right.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
        
        nameArtist.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).inset(40)
            make.right.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(200)
        }
    }
    
}
