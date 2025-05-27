//  File: NCLogoLauncher+Utils.swift
//  Project: Milestone8-iOSNotesAppClone
//  Created by: Noah Pope on 5/26/25.

import UIKit
import AVKit
import AVFoundation

class NCLogoLauncher
{
    var vc: UIViewController!
    var player: AVPlayer!
    var playerLayer: AVPlayerLayer!
    var animationDidPause = false
    
    init(vc: UIViewController) { self.vc = vc }
    
    func configureLogoLauncher()
    {
        print("logo config accessed")
        guard let url = Bundle.main.url(forResource: VideoKeys.launchScreen, withExtension: ".mp4")
        else { return }
        
        player = AVPlayer.init(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspect
        playerLayer?.frame = vc.view.layer.frame
        playerLayer?.name = VideoKeys.playerLayerName
        player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
        } catch {
            print("Background noise interruption unsuccessful")
        }
        
        player?.play()
        
        vc.view.layer.insertSublayer(playerLayer!, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
    }
    
    
    @objc func playerDidFinishPlaying()
    {
        
    }
    
    
    func removeAllAVPlayers()
    {
        if let layers = vc.view.layer.sublayers {
            for (i, layer) in layers.enumerated() {
                if layer.name == VideoKeys.playerLayerName { layers[i].removeFromSuperlayer() }
            }
        }
    }
}
