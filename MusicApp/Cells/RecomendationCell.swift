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
    let buttonLike = UIButton()
    let buttonAdd = UIButton()
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(namePlaylist)
        contentView.addSubview(nameArtist)
        contentView.addSubview(buttonLike)
        contentView.addSubview(buttonAdd)
        
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
        createStyleForButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createStyleForButtons() {
        
        var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        
        buttonLike.setImage(imageLike, for: .normal)
        buttonLike.tintColor = .white
        
        
        var imagePlus = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
        
        buttonAdd.setImage(imagePlus, for: .normal)
        buttonAdd.tintColor = .white
        
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
        
        buttonLike.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(240)
            make.right.equalTo(contentView.snp.right).inset(30)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
        buttonAdd.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(240)
            make.right.equalTo(contentView.snp.right)
            make.height.equalTo(30)
            make.width.equalTo(30)
            
        }
    }
}

