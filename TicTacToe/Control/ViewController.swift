//
//  ViewController.swift
//  TicTacToe
//
//  Created by Ryan Kanno on 5/28/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var smartButton: UIButton!
    var smartToggle:Bool = false
    @IBOutlet weak var speakerIcon: UIButton!
    var speakerImage = UIImage(systemName: "speaker.fill")
    
    @IBOutlet weak var cpuButton: UIButton!
    var cpu:Bool = false
    @IBOutlet weak var player2: UILabel!
    
    @IBOutlet var cellImages: [UIImageView]!
    var imageX:UIImage = UIImage(named: "x")!
    var imageO:UIImage = UIImage(named: "o")!
    
    @IBOutlet var cellButtons: [UIButton]!
    
    @IBOutlet weak var scoreP1: UILabel!
    @IBOutlet weak var scoreP2: UILabel!
    var score1:Int = 0
    var score2:Int = 0
    var startNewGame:Bool = false
    
    var cellOperations = CellOperations()
    var player = Player(whichPlayer: true)
    
    var timer = Timer()
    var computerChoice:Int?
    var soundPlayer = SoundPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        smartButton.alpha = 0
        speakerIcon.setImage(speakerImage, for: .normal)
        cpuButton.setTitle("PVP", for: .normal)
        player2.text = "Player 2"
        scoreP1.text = "0"
        scoreP2.text = "0"
        clearCells()
    } // End of viewDidLoad
    
    
    @IBAction func smartButtonTapped(_ sender: UIButton) {
        soundPlayer.playSwordSound()
        if smartToggle == false {
            smartButton.setTitleColor(.red, for: .normal)
            smartToggle = true
        } else {
            smartButton.setTitleColor(.black, for: .normal)
            smartToggle = false
        }
    } // End of @IBAction func smartButtonTapped
    
    
    @IBAction func cpuTapped(_ sender: UIButton) {
        soundPlayer.playPopSound()
        if cpu == false {
            player2.text = "CPU"
            cpu = true
            cpuButton.setTitle("PVC", for: .normal)
            smartButton.alpha = 1
        } else {
            player2.text = "Player 2"
            cpu = false
            cpuButton.setTitle("PVP", for: .normal)
            smartButton.alpha = 0
        }
    } // End of @IBAction func cpuTapped
    
    
    @IBAction func speakerButtonTapped(_ sender: UIButton) {
        if soundPlayer.speakerOn == true {
            // TODO: Turn off sounds
            soundPlayer.speakerOn = false
            speakerImage = UIImage(systemName: "speaker")
            speakerIcon.setImage(speakerImage, for: .normal)
            
        } else {
            // TODO: Turn on sounds
            soundPlayer.speakerOn = true
            speakerImage = UIImage(systemName: "speaker.fill")
            speakerIcon.setImage(speakerImage, for: .normal)
            
        }
    } // End of @IBAction func speakerButtonTapped
    
    
    @IBAction func cellButtonsTapped(_ sender: UIButton) {
        let tag = sender.tag
        // Play sound
        self.soundPlayer.playPopSound()
        
        var evaluate:Bool?
        
        if startNewGame == false {
            
            if player.whichPlayer == true && cellOperations.cellWasTapped[tag] == false {
                // SET IMAGE to X in the cell that was tapped
                cellImages[tag].image = imageX
                cellImages[tag].pulsate()
                cellOperations.cellWasTapped[tag] = true
              
                // *****
                evaluate = player.buildArray(player: player.whichPlayer, cellTag: tag)
                
                checkForWinAndSetScore(playerTurn: player.whichPlayer, winCondition: evaluate!)
                
                // Switch turns
                player.whichPlayer = false
                
                
                // CPU'S TURN! ********************************************************
                // Only perform CPU's turn if Player1 didn't win
                if cpu == true && startNewGame != true {
                    
                    if smartToggle == false {
                        // HAVE CPU RANDOMLY CHOOSE A CELL
                          computerChoice = player.cpuRandomChoice()
                          
                          // Make sure that the computer's choice wasn't already chosen
                          while cellOperations.cellWasTapped[computerChoice!] == true {
                              computerChoice = player.cpuRandomChoice()
                          }
                        
                          // SET IMAGE to O in the cell that cpu chose
                          // DELAY ANIMATION by 1 second
                          timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(delayedAnimation), userInfo: nil, repeats: false)
                          
                          // *****
                          evaluate = player.buildArray(player: player.whichPlayer, cellTag: computerChoice!)
                          
                          checkForWinAndSetScore(playerTurn: player.whichPlayer, winCondition: evaluate!)
                          
                          // Switch turns
                          player.whichPlayer = true
                        
                         // End of smartToggle == false
                    } else if smartToggle == true {
                        // CPU will evaluate potential win conditions for Player1 and block if there is win potential.  If not, CPU will evaluate potential win conditions for CPU and win the game if possible.  Otherwise CPU will choose a random cell.
                        computerChoice = player.cpuSmartChoice(p1Array: player.player1Array, p2Array: player.player2Array)
                        
                        while cellOperations.cellWasTapped[computerChoice!] == true {
                            computerChoice = player.cpuRandomChoice()
                        }
                        
                        // SET IMAGE to O in the cell that the cpu chose
                        // DELAY ANIMATION by 1 second
                        timer = Timer.scheduledTimer(timeInterval: 1.5, target: self, selector: #selector(delayedAnimation), userInfo: nil, repeats: false)
                        
                        // *****
                          evaluate = player.buildArray(player: player.whichPlayer, cellTag: computerChoice!)
                          
                          checkForWinAndSetScore(playerTurn: player.whichPlayer, winCondition: evaluate!)
                          
                          // Switch turns
                          player.whichPlayer = true
                        
                    }  // End of smartToggle == true
                } // End of CPU's turn
                                            
            } else if player.whichPlayer == false && cellOperations.cellWasTapped[tag] == false && cpu == false {
                // SET IMAGE to O in the cell that was tapped
                cellImages[tag].image = imageO
                cellImages[tag].pulsate()
                cellOperations.cellWasTapped[tag] = true
              
                // *****
                evaluate = player.buildArray(player: player.whichPlayer, cellTag: tag)
                
                checkForWinAndSetScore(playerTurn: player.whichPlayer, winCondition: evaluate!)
                
                // Switch turns
                player.whichPlayer = true
                
            } else if cellOperations.cellWasTapped[tag] == true {
                print("Cell \(tag) was already tapped")
                return
            }
            
        } else if startNewGame == true {
            clearCells()
            startNewGame = false
        }
    } // End of @IBAction func cellButtonsTapped
    
    
    @objc func delayedAnimation() {
        self.soundPlayer.playPopSound()
        cellImages[computerChoice!].image = imageO
        cellImages[computerChoice!].pulsate()
        cellOperations.cellWasTapped[computerChoice!] = true
    } // End of @objc func delayedAnimation
    
  
    fileprivate func checkForWinAndSetScore(playerTurn:Bool, winCondition:Bool) {
        if playerTurn == true {
            if winCondition == true {
                score1 += 1
                scoreP1.text = String(score1)
                print("Player1 score +1.  Score: \(score1)")
                // Restart the game
                startNewGame = true
            }
            return
        } else if playerTurn == false {
            if winCondition == true {
                score2 += 1
                scoreP2.text = String(score2)
                print("Player2 score +1.  Score: \(score2)")
                // Restart the game
                startNewGame = true
            }
            return
        }
    } // End of func checkForWinAndSetScore
    
    
    @IBAction func clearTapped(_ sender: Any) {
        clearCells()
        if soundPlayer.speakerOn == true {
            soundPlayer.playSwooshSound()
            print("sound on")
        } else {
            print("sound off")
        }
    } // End of func clearTapped
    
    
    @IBAction func resetTapped(_ sender: UIButton) {
        print("Reset button tapped")
        score1 = 0
        score2 = 0
        scoreP1.text = "0"
        scoreP2.text = "0"
        clearCells()
        if soundPlayer.speakerOn == true {
            soundPlayer.playSwooshSound()
            print("sound on")
        } else {
            print("sound off")
        }
    } // End of @IBAction func resetTapped
    
    
    private func clearCells() {
        for i in 0..<cellImages.count {
            cellImages[i].image = nil
        }
        for b in 0..<cellButtons.count {
            cellButtons[b].setTitle(nil, for: .normal)
        }
        for c in 0..<cellOperations.cellWasTapped.count {
            cellOperations.cellWasTapped[c] = false
        }
        for _ in 0..<player.player1Array.count {
            player.player1Array.remove(at: 0)
            print("Player1 array: \(player.player1Array)")
        }
        for _ in 0..<player.player2Array.count {
            player.player2Array.remove(at: 0)
            print("Player2 array: \(player.player2Array)")
        }
        player.whichPlayer = true
    } // end of func clearCells
    
    
} // End of class ViewController

