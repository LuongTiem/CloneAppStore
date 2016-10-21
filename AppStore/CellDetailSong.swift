//
//  CellDetailSong.swift
//  AppStore
//
//  Created by ReasonAmu on 10/22/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import AVFoundation

class CellDetailSong: UITableViewCell {
    
    @IBOutlet weak var btn_Music: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    var detailSong : DetailSong?
    var playMP3 = AVPlayer()
    var playing : Bool = false
    @IBAction func actionplay_Music(_ sender: AnyObject) {
        play(detailSong: detailSong!)
        playingAndPause()
        print("NOw")
    }
    
    
    
    func play(detailSong : DetailSong){
        let url = URL(string: detailSong.previewUrl!)!
        let playItem = AVPlayerItem(url: url)
        playMP3 = AVPlayer(playerItem: playItem)
        playMP3.rate = 1.0
        playMP3.volume = 0.5
        
        
        
        
    }
    
    func playingAndPause(){
        if (playing == true){
            btn_Music.setImage(UIImage(named: "Play"), for: .normal)
            
            playMP3.pause()
            playing = false
        }else{
            btn_Music.setImage(UIImage(named: "Pause"), for: .normal)
            
            playMP3.play()
            playing = true
        }
    }
    
    
    
    
    
}
