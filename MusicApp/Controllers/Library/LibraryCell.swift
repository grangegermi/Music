//
//  LibraryCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//
import UIKit
import SnapKit

class LibraryCell: UITableViewCell {
    
    static let id = "LibraryCell"
    
    let nameArtist = UILabel()
    let viewImage = UIImageView()
    let nameSong = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameArtist)
        contentView.addSubview(viewImage)
        contentView.addSubview(nameSong)
        createConstraints()
        nameArtist.textColor = .white
        nameSong.textColor = .white
        viewImage.contentMode = .scaleToFill
        nameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 14)
        nameSong.font = UIFont(name: "Noto Sans Kannada Regular", size: 12)
        
    }

    func createConstraints() {
        
        viewImage.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(5)
            make.top.equalTo(contentView.snp.top).inset(5)
            make.width.equalTo(30)
            make.height.equalTo(30)
            
        }
        nameArtist.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(50)
            make.top.equalTo(contentView.snp.top).inset(5)
            make.width.equalTo(100)
            make.height.equalTo(30)
            
        }
        nameSong.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(50)
            make.top.equalTo(contentView.snp.top).inset(30)
            make.width.equalTo(100)
            make.height.equalTo(30)
            
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
