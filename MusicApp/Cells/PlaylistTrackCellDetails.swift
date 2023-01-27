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
    let buttonLike = UIButton()
    let buttonAdd = UIButton()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        //        contentView.addSubview(view)
        
        contentView.addSubview(imageView)
        contentView.addSubview(labelNameTrack)
        contentView.addSubview(labelNameArtist)
        contentView.addSubview(buttonLike)
        contentView.addSubview(buttonAdd)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        labelNameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        labelNameTrack.font = UIFont(name: "Noto Sans Kannada Regular", size: 14)
        labelNameArtist.textColor = .white
        labelNameArtist.numberOfLines = 0
        
        labelNameTrack.textColor = .white
        
        
        createConstraints()
        createStyleForButtons()
    }
    
    func createStyleForButtons() {
        
        var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        
        buttonLike.setImage(imageLike, for: .normal)
        buttonLike.tintColor = .white
        
        
        var imagePlus = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        
        buttonAdd.setImage(imagePlus, for: .normal)
        buttonAdd.tintColor = .white
        buttonAdd.contentEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
        
    }
    
    func createConstraints() {
        
        imageView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.centerX.equalTo(contentView.snp.centerX)
            //            make.width.equalTo(200)
            make.height.equalTo(150)
        }
        labelNameArtist.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top).inset(160)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        labelNameTrack.snp.makeConstraints { make in
            
            make.left.equalTo(contentView.snp.left)
            make.top.equalTo(contentView.snp.top).inset(200)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        buttonLike.snp.makeConstraints { make in
            
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top).inset(155)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        buttonAdd.snp.makeConstraints { make in
            
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top).inset(190)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
