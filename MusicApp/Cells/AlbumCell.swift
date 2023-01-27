//
//  CellHome.swift
//  MusicApp
//
//  Created by Даша Волошина on 21.12.22.
//

import UIKit
import SnapKit


class AlbumCell: UICollectionViewCell {
    
    var selectionHandler: ((Item) -> Void)?
    
    static let id = "album"
    
    let imageView = UIImageView()
    let nameAlbums = UILabel()
    let nameArtist = UILabel()
    let countTracks = UILabel()
    
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameAlbums)
        contentView.addSubview(nameArtist)
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        nameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 14)
        nameArtist.textColor = .white
        
        nameAlbums.font = UIFont(name: "Noto Sans Kannada Regular", size: 12)
        nameAlbums.textColor = .white
        nameArtist.numberOfLines = 0
        nameAlbums.numberOfLines = 0
        createConstraints()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func createConstraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).inset(10)
            make.width.equalTo(contentView.snp.width)
            make.height.equalTo(80)
            
            nameArtist.snp.makeConstraints { make in
                
                make.height.equalTo(50)
                make.width.equalTo(120)
                make.top.equalTo(contentView.snp.top).inset(90)
            }
            
            nameAlbums.snp.makeConstraints { make in
                
                make.height.equalTo(50)
                make.width.equalTo(120)
                make.top.equalTo(contentView.snp.top).inset(120)
            }
        }
        
    }
}
