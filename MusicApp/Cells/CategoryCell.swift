//
//  CategoryCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 5.01.23.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    static let id = "CategoryCell"
    let view = UIView()
    let label = UILabel()
    let imageView = UIImageView()
      
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(view)
        view.addSubview(label)
        view.addSubview(imageView)
        createConstraints()
        var color = UIColor(red: .random(in:0...1), green: .random(in:0...1), blue: .random(in:0...1), alpha: 0.8)
        createStyles(color: color)
        
    }
    
    func createStyles(color:UIColor){
        
        view.backgroundColor = color
        view.layer.cornerRadius = 6
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        
        label.numberOfLines = 0
        label.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
        label.textColor = .white
        
    }
    
    func createConstraints() {
        view.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom)
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(5)
            make.width.equalTo(100)
            make.top.equalTo(view.snp.top).inset(10)
            make.height.equalTo(60)
        }
        
        imageView.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right)
            make.width.equalTo(80)
            make.top.equalTo(view.snp.bottom).inset(80)
            make.height.equalTo(80)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
