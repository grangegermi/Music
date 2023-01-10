//
//  CellForSettingsTableViewCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//
import UIKit

import SnapKit

class CellForSettings: UITableViewCell {

    static let id = "CellForSettings"
    
    let labelTitle = UILabel()
    let labelSubTitle = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelSubTitle)
   
        createConstraints()
        createStyleLabels()
    }
    
    func createConstraints() {
        labelTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
            make.width.equalTo(400)
            make.height.equalTo(30)
            
        }
        
        labelSubTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(10)
            make.top.equalTo(labelTitle.snp.bottom).inset(30)
            make.width.equalTo(200)
            make.height.equalTo(30)
            
        }
    }
    
    func createStyleLabels() {
        labelTitle.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        labelTitle.textColor = .white
        labelSubTitle.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        labelSubTitle.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
