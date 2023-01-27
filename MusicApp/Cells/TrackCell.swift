//
//  TrackCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 21.12.22.
//

import UIKit

class TrackCell: UICollectionViewCell {
    
    static let id = "TrackCell"
    
    let imageView = UIImageView()
    let nameDescription = UILabel()
    let nameArtist = UILabel()
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameDescription)
        contentView.addSubview(nameArtist)
        nameArtist.textColor = .white
        nameDescription.textColor = .white
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        nameArtist.numberOfLines = 0
        nameDescription.numberOfLines = 0
        
        nameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 14)
        nameDescription.font = UIFont(name: "Noto Sans Kannada Regular", size: 12)
        
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
        
        nameArtist.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(210)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width)
        }
        
        nameDescription.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(250)
            make.height.equalTo(40)
            make.width.equalTo(contentView.snp.width)
        }
        
        
    }
    
}
