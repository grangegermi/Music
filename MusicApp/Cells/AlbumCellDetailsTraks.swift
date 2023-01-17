//
//  AlbumCellDetailsTraks.swift
//  MusicApp
//
//  Created by Даша Волошина on 1.01.23.
//

import UIKit
import SnapKit

class AlbumCellDetailsTraks: UICollectionViewCell {
    
     static let id = "AlbumCellDetailsTraks"
    
    let labelNameArtist = UILabel()
    let labelNameTrack = UILabel()
    let labelNumber = UILabel()
    let view = UIView()
    let buttonLike = UIButton()
    let buttonAdd = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(view)
  
        let blur = UIBlurEffect(style: .dark)

        let visualEffect = UIVisualEffectView(effect: blur)
        view.addSubview(visualEffect)
        visualEffect.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.right.equalTo(view.snp.right)
        }
        view.layer.cornerRadius = 6
        view.addSubview(labelNumber)
        view.addSubview(labelNameTrack)
        view.addSubview(labelNameArtist)
        
        contentView.addSubview(buttonLike)
        contentView.addSubview(buttonAdd)
        
        labelNameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        labelNameArtist.textColor = .white
        
        labelNameTrack.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        labelNameTrack.textColor = .white
        
        labelNumber.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        labelNumber.textColor = .white
        
    
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = true
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
        
        
    }
    
    func createConstraints() {
        
        view.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        labelNumber.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(20)
            make.width.equalTo(300)
            make.height.equalTo(30)
            make.centerY.equalTo(view.snp.centerY)
          
        }
        
        buttonLike.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(60)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(view.snp.centerY)
          
        }
        
        buttonAdd.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).inset(30)
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.centerY.equalTo(view.snp.centerY)
          
        }
        
        labelNameArtist.snp.makeConstraints { make in
            
            make.left.equalTo(view.snp.left).inset(60)
            make.top.equalTo(view.snp.top).inset(10)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        labelNameTrack.snp.makeConstraints { make in
            
            make.left.equalTo(view.snp.left).inset(60)
            make.top.equalTo(view.snp.top).inset(40)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
