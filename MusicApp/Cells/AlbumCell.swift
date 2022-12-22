//
//  CellHome.swift
//  MusicApp
//
//  Created by Даша Волошина on 21.12.22.
//

import UIKit
import SnapKit

class AlbumCell: UICollectionViewCell {
    
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
        contentView.addSubview(countTracks)

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
        
        nameAlbums.snp.makeConstraints { make in
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
