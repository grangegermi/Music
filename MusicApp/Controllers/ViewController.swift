//
//  ViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import AVFoundation
import SnapKit

class ViewController: UIViewController {
    
   @objc var queuePlayer =  AVQueuePlayer()
    
    private  var token: NSKeyValueObservation?
    
    var index = 0
    var avItem: AVPlayerItem!
    var itemArray:[String] = []
    
    let buttonBack = UIButton()
    let buttonPlay = UIButton()
    let buttonStop = UIButton()
    let buttonForward = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(buttonPlay)
        view.addSubview(buttonStop)
        view.addSubview(buttonBack)
        view.addSubview(buttonForward)
        
        createStyle ()
        createconstraints ()
        createPlayer ()
        
   
        
//        token = queuePlayer.observe(\.currentItem, changeHandler: { player, _ in
//            if self.queuePlayer.items().count == 1 {
//                self.createPlayer()
//            }
//        })
    }
    
    func createPlayer () {
        
        DispatchQueue.main.async {
            
            self.avItem = AVPlayerItem(url: URL(string: self.itemArray[ self.index])!)
            self.queuePlayer = AVQueuePlayer(items: [ self.avItem])
            self.queuePlayer.play()
        }
        
    }
       
//      
//            
//            //        for item in itemArray {
//            //            avItem = AVPlayerItem(url: URL(string:item)!)
//            //            queuePlayer.insert(avItem, after: queuePlayer.items().last)
//            //            queuePlayer.play()
//            //        }
//        }
//    }
    @objc func tapToBack(_ sender:UIButton){
        print("back")
        
//        index -= 1
////    
//            if index <= (trackItems.count - 1 ){
//         
//        }
    }
    
    @objc func tapToForward(_ sender:UIButton){
        print("forward")
//        queuePlayer.items() += 1
        
        
        
//
//        if index >= trackItems.count{
//            index = 0
//        }
    }
    
    @objc func tapToPlay(_ sender:UIButton){
        print("play")
        if queuePlayer.timeControlStatus == .playing {
       
           queuePlayer.pause()
                buttonStop.isHidden = false
                buttonPlay.isHidden = true
                
        } else {
             queuePlayer.play()
               
                buttonStop.isHidden = true
                buttonPlay.isHidden = false
        }
    }
    
    func createStyle () {
        var imageBack = UIImage(systemName: "backward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        buttonBack.setImage(imageBack, for: .normal)
        buttonBack.addTarget(self, action: #selector(tapToBack), for: .touchUpInside)
        buttonBack.tintColor = .white
        
        var imageForward = UIImage(systemName: "forward.end.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        buttonForward.setImage(imageForward, for: .normal)
        buttonForward.addTarget(self, action: #selector(tapToForward), for: .touchUpInside)
        buttonForward.tintColor = .white
        
        var imagePlay = UIImage(systemName: "pause.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        imagePlay?.withTintColor(.black)
        buttonPlay.setImage(imagePlay, for: .normal)
        buttonPlay.addTarget(self, action: #selector(tapToPlay), for: .touchUpInside)
        buttonPlay.tintColor = .white
        
        
        var imageStop = UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 50, weight: .regular))
        
        buttonStop.setImage(imageStop, for: .normal)
        buttonStop.tag = 2
        buttonStop.isHidden = true
        buttonStop.tintColor = .white
        buttonStop.addTarget(self, action: #selector(tapToPlay), for: .touchUpInside)
    }
    
    func createconstraints () {
    
        buttonPlay.snp.makeConstraints { make in
        make.top.equalTo(view.snp.bottom).inset(200)
        make.centerX.equalTo(view.snp.centerX)
        
        
    }
    
    buttonStop.snp.makeConstraints { make in
        make.top.equalTo(view.snp.bottom).inset(200)
        make.centerX.equalTo(view.snp.centerX)
        make.width.equalTo(50)
        make.height.equalTo(50)
        
    }
    
    buttonBack.snp.makeConstraints { make in
        
        make.left.equalTo(view.snp.left).inset(50)
        make.top.equalTo(view.snp.bottom).inset(200)
        
    }
    
    buttonForward.snp.makeConstraints { make in
        
        make.right.equalTo(view.snp.right).inset(50)
        make.top.equalTo(view.snp.bottom).inset(200)
        
    }
}
}

