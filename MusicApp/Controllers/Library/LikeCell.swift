//
//  LikeCell.swift
//  MusicApp
//
//  Created by Даша Волошина on 16.01.23.
//

import UIKit

class LikeCell: UITableViewCell {

    static let id = "LikeCell"
   
   let labelNameArtist = UILabel()
   let labelNameTrack = UILabel()
   let labelNumber = UILabel()
   let view = UIView()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
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
       
      
     
       
       labelNameArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 16)
       labelNameArtist.textColor = .white
       
       labelNameTrack.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
       labelNameTrack.textColor = .white
       
       labelNumber.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
       labelNumber.textColor = .white
       
   
       createConstraints()
      
   }
  
   
   func createConstraints() {
     
       labelNumber.snp.makeConstraints { make in
           make.top.equalTo(25)
           make.left.equalTo(view.snp.left).inset(10)
           make.width.equalTo(300)
           make.height.equalTo(30)
//           make.centerY.equalTo(view.snp.centerY)
         
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
