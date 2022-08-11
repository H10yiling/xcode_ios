//
//  ViewController.swift
//  IphoneAlertsMusicDemo
//
//  Created by 侯懿玲 on 2022/8/11.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var audio:AVPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // call what ever function you want.
        playAlarm()
    }
    
    func stopAlarm() {
        // To pause or stop audio in swift 5 audio.stop() isn't working
        audio.pause()
    }
    
    func playAlarm() {
        // need to declare local path as url
        let url = URL(string: "http://uk3.internet-radio.com:8021/listen.pls")
//        let url = Bundle.main.url(forResource: "http://uk3.internet-radio.com:8021/listen.pls", withExtension: "mp3")
        // now use declared path 'url' to initialize the player
        audio = AVPlayer.init(url: url!)
        // after initialization play audio its just like click on play button
        audio.play()
    }
    
}

/*
 // All
 let mediaItems = MPMediaQuery.songsQuery().items
 // Or you can filter on various property
 // Like the Genre for example here
 var query = MPMediaQuery.songsQuery()
 let predicateByGenre = MPMediaPropertyPredicate(value: "Rock", forProperty: MPMediaItemPropertyGenre)
 query.filterPredicates = NSSet(object: predicateByGenre)
 */

/*
 // Get the music player.
 let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
 // Add a playback queue containing all songs on the device.
 musicPlayer.setQueue(with: .songs())
 */


