//
//  AudioPlayerVC.swift
//  SpritualTablets
//
//  Created by Veluri Goutham on 28/06/23.
//

import UIKit
import AVFAudio
import AVFoundation

class AudioPlayerVC: UIViewController {

    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    fileprivate let seekDuration: Float64 = 10
    
    @IBOutlet weak var lblOverallDuration: UILabel!
    @IBOutlet weak var lblcurrentText: UILabel!
    @IBOutlet weak var playbackSlider: UISlider!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var ButtonPlay: UIButton!
    @IBOutlet weak var audioPlayLabel: UILabel!
    
    var playerLink = ""
    var playerName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.hidesBackButton = false
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background_gradient.jpg")!)
        
        loadingView.isHidden = true
        print(playerLink)
        print(playerName)
        audioPlayLabel.text = playerName
        
      //  let url = URL(string: playerLink)
        guard let url = URL(string: playerLink) else { return }
        
        let playerItem:AVPlayerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        // Add playback slider
        playbackSlider.minimumValue = 0
        
        playbackSlider.addTarget(self, action: #selector(AudioPlayerVC.playbackSliderValueChanged(_:)), for: .valueChanged)
        
        let duration : CMTime = playerItem.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        lblOverallDuration.text = self.stringFromTimeInterval(interval: seconds)
        
        let duration1 : CMTime = playerItem.currentTime()
        let seconds1 : Float64 = CMTimeGetSeconds(duration1)
        lblcurrentText.text = self.stringFromTimeInterval(interval: seconds1)
        
        playbackSlider.maximumValue = Float(seconds)
        playbackSlider.isContinuous = true
        playbackSlider.tintColor = UIColor(red: 0.93, green: 0.74, blue: 0.00, alpha: 1.00)
        
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
                let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
                self.playbackSlider.value = Float ( time );
                
                self.lblcurrentText.text = self.stringFromTimeInterval(interval: time)
            }
            
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
                print("IsBuffering")
                self.ButtonPlay.isHidden = true
                self.loadingView.isHidden = false
            } else {
                //stop the activity indicator
                print("Buffering completed")
                self.ButtonPlay.isHidden = false
                self.loadingView.isHidden = true
            }
            
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        player?.pause()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func ButtonGoToBackSec(_ sender: Any) {
        if player == nil { return }
        let playerCurrenTime = CMTimeGetSeconds(player!.currentTime())
        var newTime = playerCurrenTime - seekDuration
        if newTime < 0 { newTime = 0 }
        player?.pause()
        let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
        player?.seek(to: selectedTime)
        player?.play()
    }
    
    @IBAction func ButtonPlay(_ sender: Any) {
        print("play Button")
        if player?.rate == 0
        {
            player!.play()
            self.ButtonPlay.isHidden = true
            self.loadingView.isHidden = false
            ButtonPlay.setImage(UIImage(named: "ic_orchadio_pause"), for: UIControl.State.normal)
        } else {
            player!.pause()
            ButtonPlay.setImage(UIImage(named: "ic_orchadio_play"), for: UIControl.State.normal)
        }
    }
    
    @IBAction func ButtonForwardSec(_ sender: Any) {
        if player == nil { return }
        if let duration  = player!.currentItem?.duration {
            let playerCurrentTime = CMTimeGetSeconds(player!.currentTime())
            let newTime = playerCurrentTime + seekDuration
            if newTime < CMTimeGetSeconds(duration)
            {
                let selectedTime: CMTime = CMTimeMake(value: Int64(newTime * 1000 as Float64), timescale: 1000)
                player!.seek(to: selectedTime)
            }
            player?.pause()
            player?.play()
        }
    }
    
    @objc func playbackSliderValueChanged(_ playbackSlider:UISlider)
    {
        let seconds : Int64 = Int64(playbackSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        
        player!.seek(to: targetTime)
        
        if player!.rate == 0
        {
            player?.play()
        }
    }
    
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        ButtonPlay.setImage(UIImage(named: "ic_orchadio_play"), for: UIControl.State.normal)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let interval = Int(interval)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    
}
