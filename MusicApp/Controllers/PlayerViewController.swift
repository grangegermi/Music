//
//  ViewController.swift
//  MusicApp
//
//  Created by Даша Волошина on 18.12.22.
//

import UIKit
import AVFoundation
import SnapKit
import SDWebImage

class PlayerViewController: UIViewController {
    
    var queuePlayer =  AVQueuePlayer()
    
    var model = ModelPlayer()
    
    private var timeObserver: Any?
    var isSeeking = false
    
    var index = 0
    var avItem: AVPlayerItem!
    var asset:AVAsset!
    var key:[String] = ["track"]
    
    let buttonBack = UIButton()
    let buttonPlay = UIButton()
    let buttonStop = UIButton()
    let buttonForward = UIButton()
    let slider = UISlider()
    let viewImage = UIImageView()
    var label = UILabel()
    var labelArtist = UILabel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = UIVieww()
        view.addSubview(viewImage)
        view.addSubview(label)
        view.addSubview(labelArtist)
        view.addSubview(slider)
        
        view.backgroundColor = .black
        view.addSubview(buttonPlay)
        view.addSubview(buttonStop)
        view.addSubview(buttonBack)
        view.addSubview(buttonForward)
        
        asset = AVAsset(url:  URL(string: model.itemArray[index])!)
        createStyle()
        createconstraints()
        createPlayer()
        createSlider()
        self.model.viewController = self
        
    }
    
    func createPlayer() {
        let group = DispatchGroup()
        
        group.enter()
        
        asset.loadValuesAsynchronously(forKeys: key) {
        }
        
        group.leave()
        group.notify(queue: .main) { [weak self] in
            
            NotificationCenter.default.addObserver(self, selector: #selector(self?.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self?.avItem)
            
            self?.avItem = AVPlayerItem(asset:AVAsset(url: URL(string: (self?.model.itemArray[self?.index ?? 0])!)!))
            
//            print(self?.queuePlayer.items().count)
            self?.queuePlayer.insert((self?.avItem)!, after: nil)
            self?.viewImage.sd_setImage(with: self?.model.imageView[self!.index])
            self?.label.text = self?.model.names[self!.index]
            self?.labelArtist.text = self?.model.namesTrack[self!.index]
        }
        
        self.queuePlayer.play()
        
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        buttonStop.isHidden = false
        buttonPlay.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        slider.maximumValue = Float(queuePlayer.currentItem?.duration.seconds ?? 30)
        
        timeObserver =  queuePlayer.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: 1000), queue: .main) { [weak self] time in
            
            if ((self?.isSeeking) != nil) {
                self?.slider.setValue(Float(time.seconds), animated: false)
            }
        }
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let timeObserverToken = timeObserver {
            queuePlayer.removeTimeObserver(timeObserverToken)
            self.timeObserver = nil
        }
    }
    
    func createSlider() {
        
        slider.tintColor = .black
        slider.addTarget(self, action: #selector(sliderChange), for: .touchUpInside)
    }
    
    
    @objc func sliderChange(_ sender: UISlider){
        
        isSeeking = true
        
        queuePlayer.seek(to: CMTime(seconds: Double(slider.value), preferredTimescale: 1000), completionHandler: { [weak self]  (completed) in
            
            if completed {
                self?.isSeeking = false
            }
        })
        
    }
    
    @objc func tapToBack(_ sender:UIButton){
        print("back")
        
        index -= 1
        queuePlayer.remove(avItem)
        createPlayer()
        
        if index <= (queuePlayer.items().count - 1){
            index = queuePlayer.items().count
        }
        
        if buttonPlay.isHidden == true {
            buttonStop.isHidden = true
            buttonPlay.isHidden = false
        }
    }
    @objc func tapToForward(_ sender:UIButton){
        print("forward")
        
        createPlayer()
        queuePlayer.advanceToNextItem()
        index += 1
        
        if index >= model.itemArray.count {
            index = queuePlayer.items().count
            
        }
        
        if buttonPlay.isHidden == true {
            buttonStop.isHidden = true
            buttonPlay.isHidden = false
        }
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
            createPlayer()
        }
    }
    
    func createStyle () {
        
        viewImage.contentMode = .scaleToFill
        
        label.font = UIFont(name: "Noto Sans Kannada Regular", size: 16)
        label.textColor = .white
        
        labelArtist.font = UIFont(name: "Noto Sans Kannada Bold", size: 18)
        labelArtist.textColor = .white
        
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
        
        viewImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).inset(100)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
            
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(50)
            make.top.equalTo(view.snp.bottom).inset(350)
            make.width.equalTo(view.snp.width).multipliedBy(300)
            make.height.equalTo(30)
        }
        
        labelArtist.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(50)
            make.top.equalTo(view.snp.bottom).inset(380)
            make.width.equalTo(view.snp.width).multipliedBy(300)
            make.height.equalTo(30)
        }
        
        slider.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(40)
            make.top.equalTo(view.snp.bottom).inset(290)
            make.width.equalTo(300)
            make.height.equalTo(30)
        }
        
        
        buttonPlay.snp.makeConstraints { make in
            
            make.top.equalTo(view.snp.bottom).inset(220)
            make.centerX.equalTo(view.snp.centerX)
            
            
        }
        
        buttonStop.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).inset(220)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(50)
            make.height.equalTo(50)
            
        }
        
        buttonBack.snp.makeConstraints { make in
            
            make.left.equalTo(view.snp.left).inset(50)
            make.top.equalTo(view.snp.bottom).inset(220)
            
        }
        
        buttonForward.snp.makeConstraints { make in
            
            make.right.equalTo(view.snp.right).inset(50)
            make.top.equalTo(view.snp.bottom).inset(220)
            
        }
    }
}

