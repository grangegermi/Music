//
//  SearchCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 6.01.23.
//

import UIKit
import SnapKit

class SearchCell: UITableViewCell {

    static let id = "SearchCell"
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
     
        label.numberOfLines = 0
        label.textColor = .white
        label.font =  UIFont(name: "Noto Sans Kannada Regular", size: 16)!
        label.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).inset(10)
            make.top.equalTo(contentView.snp.top).inset(10)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
