//
//  TrackCellDetails.swift
//  MusicApp
//
//  Created by Даша Волошина on 28.12.22.
//

import UIKit
import SnapKit

class PlaylistTrackCellDetails: UICollectionViewCell {
    
    static let id = "TrackCellDetails"
    
    let labelNameArtist = UILabel()
    let labelNameTrack = UILabel()
    let imageView = UIImageView()
    let view = UIView()
    
    override init(frame:CGRect){
        super.init(frame:frame)
       
//        contentView.addSubview(view)
        
        contentView.addSubview(imageView)
        contentView.addSubview(labelNameTrack)
        contentView.addSubview(labelNameArtist)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        labelNameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        labelNameTrack.font = UIFont(name: "Noto Sans Kannada Regular", size: 14)
        createConstraints()
        labelNameArtist.textColor = .white
        labelNameTrack.textColor = .white
  
    }
    
    func createConstraints() {

        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.centerX.equalTo(contentView.snp.centerX)
//            make.width.equalTo(200)
            make.height.equalTo(190)
        }
        labelNameArtist.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left).inset(10)
            make.top.equalTo(contentView.snp.top).inset(200)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        
        labelNameTrack.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left).inset(10)
            make.top.equalTo(contentView.snp.top).inset(220)
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
