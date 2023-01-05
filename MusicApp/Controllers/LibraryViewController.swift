//
//  LibraryViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit

class LibraryViewController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 10, y: 10, width: 300, height: 30))
    var track = Tracks(album: Album(album_type: "", available_markets: [], id: "", images: [], name: "", release_date: "", total_tracks: 0, artists: []), artists: [], available_markets: [], disc_number: 0, duration_ms: 0, id: "", name: "", preview_url: "")
    override func loadView() {
        super.loadView()
        view = UIVieww()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.backgroundColor = .red
        
        navigationController?.navigationBar.topItem?.title = "Library"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        ApiCaller.sharedCaller.getRecommendationsTrack(track: track) { result in
            
        }
        
        view.addSubview(button)
    }
   
 
}

extension UIView {
    
    func makeGradient () {
  
//        let layer = CAGradientLayer()
//        layer.insertSublayer(layer, at: 0)
//        let color1 =
//        let color2 =
//        let color3 =
//
//        layer.locations = [0.0,0.5, 1.0]
//        layer.transform = CATransform3DMakeRotation(CGFloat.pi/2, 1, 1 , 1)
         
//        layer.startPoint  = .init(x:0.0, y: 0.0)
//        layer.endPoint = .init(x: 1, y: 1)
//          self.layer.insertSublayer(layer, at: 0)
  
      }
}
    
extension UIColor{
    var redColor: UIColor {
        return UIColor(red: 116/255, green: 121/255, blue: 124/255, alpha: 1)
    }
    var greenColor: UIColor {
        return UIColor(red:91/255, green: 94/255, blue: 98/255, alpha: 1)
    }
    var blueColor: UIColor {
        return UIColor(red: 58/255, green: 65/255, blue: 64/255, alpha: 1)
    }
}
   
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
