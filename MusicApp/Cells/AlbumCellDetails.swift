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
//    let buttonLike = UIButton()
//    let buttonAdd = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(label)
      
        contentView.addSubview(imageView)
        contentView.addSubview(labelDescription)
//        contentView.addSubview(buttonLike)
//        contentView.addSubview(buttonAdd)
//      contentView.backgroundColor = .black
       
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
  
        label.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        label.textColor = .white
        labelDescription.font = UIFont(name: "Noto Sans Kannada Regular", size: 14)
        labelDescription.numberOfLines = 0
        labelDescription.textColor = .white
        
    
       
        
        createConstraints()
        createStyleForButtons()
        
        
    }
    
    
    func createStyleForButtons() {
//
//        var imageLike = UIImage(systemName: "suit.heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
//
//        buttonLike.setImage(imageLike, for: .normal)
//        buttonLike.tintColor = .white
//
//
//        var imagePlus = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .regular))
//
//        buttonAdd.setImage(imagePlus, for: .normal)
//        buttonAdd.tintColor = .white
        
        
    }
    
    func createConstraints() {
        
        imageView.snp.makeConstraints { make in
            
            make.top.equalTo(contentView.snp.top).inset(10)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
//          make.width.equalTo(200)
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
        
//        buttonLike.snp.makeConstraints { make in
//            make.right.equalTo(contentView.snp.right).inset(40)
//            make.top.equalTo(contentView.snp.top).inset(260)
//            make.height.equalTo(20)
//            make.width.equalTo(20)
//        }
//        
//        buttonAdd.snp.makeConstraints { make in
//            make.right.equalTo(contentView.snp.right)
//            make.top.equalTo(contentView.snp.top).inset(260)
//            make.height.equalTo(20)
//            make.width.equalTo(20)
//        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
