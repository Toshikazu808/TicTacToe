//
//  SoundPlayer.swift
//  TicTacToe
//
//  Created by Ryan Kanno on 5/30/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import Foundation
import AVFoundation


struct SoundPlayer {
    
    var audioPlayer:AVAudioPlayer?
    var speakerOn:Bool = true
    let popSound:String = "lipsPop"
    let swooshSound:String = "swoosh"
    let swordSound:String = "SwordSoundEffect"
    var smartToggle:Bool = false
    
    mutating func playSound(filename:String) {
        // Get the url
        let url = Bundle.main.url(forResource: filename, withExtension: "m4a")
        
        // Make sure that we've got the url, otherwise abort
        guard url != nil else {
            return
        }
        // Create the audio player and play the sound
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url!)
            audioPlayer?.play()
        } catch {
            print("error playing audio")
        }
    } // End of func playSound
    
    
    mutating func playPopSound() {
        if speakerOn == true {
            playSound(filename: popSound)
            print("sound on")
        } else {
            print("sound off")
        }
    }
    
    
    mutating func playSwooshSound() {
        if speakerOn == true {
            playSound(filename: swooshSound)
            print("sound on")
        } else {
            print("sound off")
        }
    }
    
    
    mutating func playSwordSound() {
        if speakerOn == true && smartToggle == false {
            playSound(filename: swordSound)
            smartToggle = true
            print("sound on")
        } else {
            smartToggle = false
            print("sound off")
        }
    }
    
      
} // End of struct SoundPlayer
