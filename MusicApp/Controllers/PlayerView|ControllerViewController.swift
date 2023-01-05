//
//  PlayerView|ControllerViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 30.12.22.
//

import UIKit
import SnapKit
import AVFoundation
import SDWebImage

class PlayerViewController: UIViewController {
    
    var player: AVPlayer!
    var playerAudio:AVAudioPlayer!
    var index = 0
    var trackItems:[String] = []
    var image:[URL] = []
    var items:[Items] = []
    
   
    let slider = UISlider()
    let viewImage = UIImageView()
    let buttonBack = UIButton()
    let buttonPlay = UIButton()
    let buttonStop = UIButton()
    let buttonForward = UIButton()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view = UIVieww()
        view.addSubview(viewImage)
        view.addSubview(buttonPlay)
        view.addSubview(buttonStop)
        view.addSubview(buttonBack)
        view.addSubview(buttonForward)
        view.addSubview(slider)
//
        
        createPlayer ()
        createconstraints ()
        createStyle ()
        createSlider()
}
//MARK: -  Make Player
    
    func createPlayer () {
       
        player = AVPlayer(url:(URL(string: trackItems[index])!))
        
        slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 10)
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1000), queue: .main) { time in
            self.slider.value = Float(time.seconds)
        }
        player.play()
//        viewImage.sd_setImage(with: items.compactMap({$0.track.album?.images.first?.url})[index])
        viewImage.sd_setImage(with: image[index])
        
    }
    func createSlider() {
        
       
        slider.tintColor = .black
        slider.addTarget(self, action: #selector(sliderChange), for: .touchUpInside)
        
    }
    
//MARK: - Style Player
    
    func createStyle () {
       
        viewImage.contentMode = .scaleAspectFill

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
    
    @objc func sliderChange(_ sender: UISlider){
        player.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000))
        
    }
//MARK: -  Buttons for player
    
    @objc func tapToBack(_ sender:UIButton){
        print("back")
        index -= 1
        createPlayer()
            if index <= (trackItems.count - 1 ){
              
              
            }
    }
    
    @objc func tapToForward(_ sender:UIButton){
        print("forward")
        index += 1
        createPlayer()
        if index >= trackItems.count{
            index = 0
        }
    }
    
    @objc func tapToPlay(_ sender:UIButton){

        if player.timeControlStatus == .playing {
            player.pause()
                buttonStop.isHidden = false
                buttonPlay.isHidden = true
                
        }else {
            player.play()
                buttonStop.isHidden = true
                buttonPlay.isHidden = false
                
        }
    }
//MARK: -  Make Constraints
    func createconstraints () {

        viewImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).inset(150)
            make.width.equalTo(view.snp.width).multipliedBy(0.4)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)

        }

        slider.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(40)
            make.bottom.equalTo(view.snp.bottom).inset(300)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        buttonPlay.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(200)
            make.centerX.equalTo(view.snp.centerX)

            
        }
        buttonStop.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).inset(200)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(50)
            make.height.equalTo(50)
            
        }

        buttonBack.snp.makeConstraints { make in
            
            make.left.equalTo(view.snp.left).inset(50)
            make.bottom.equalTo(view.snp.bottom).inset(200)

        }
        
        buttonForward.snp.makeConstraints { make in
        
            make.right.equalTo(view.snp.right).inset(50)
            make.bottom.equalTo(view.snp.bottom).inset(200)

        }
    }
}
