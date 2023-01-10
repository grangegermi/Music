//
//  ColorsView.swift
//  MusicApp
//
//  Created by Даша Волошина on 9.01.23.
//

import Foundation
import UIKit

class UIVieww:UIView {
    let gradientLayer = CAGradientLayer()
    
    override init(frame:CGRect){
        super.init(frame:frame)
        
        
        let color1 = UIColor(red: 89/255, green: 89/255, blue: 89/255, alpha: 1)
        let color2 = UIColor(red: 69/255, green: 69/255, blue: 69/255, alpha: 1)
        let color3 = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1)
        gradientLayer.colors = [color1.cgColor, color2.cgColor,color3.cgColor]
        gradientLayer.shouldRasterize = true
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
                
       
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
