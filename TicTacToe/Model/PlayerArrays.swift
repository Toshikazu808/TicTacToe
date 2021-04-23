//
//  PlayerArrays.swift
//  TicTacToe
//
//  Created by Ryan Kanno on 5/29/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import Foundation

struct Player {
    
    var whichPlayer:Bool // X is true, O is false
    init(whichPlayer:Bool) {
        self.whichPlayer = whichPlayer
    }
    
    var cellOperations = CellOperations()
    
    var player1Array:[Int] = []
    var player2Array:[Int] = []
    var computerChoice:Int?
    
    
    mutating func cpuRandomChoice() -> Int {
        computerChoice = Int(arc4random_uniform(9))
        
        while cellOperations.cellWasTapped[computerChoice!] == true {
            computerChoice = Int(arc4random_uniform(9))
            print("Computer chose \(computerChoice!)")
        }
        return computerChoice!
    } // End of func cpuRandomChoice
    
    
    mutating func buildArray(player:Bool, cellTag:Int) -> Bool {
        if player == true {
            player1Array.append(cellTag)
            player1Array.sort()
            print("Player1 Array: \(player1Array)")
            
            let didWin = splitArrayAndCompare(array: player1Array)
            if didWin == true {
                return true
            }

        } else {
            player2Array.append(cellTag)
            player2Array.sort()
            print("Player2 Array: \(player2Array)")
            
            let didWin = splitArrayAndCompare(array: player2Array)
            if didWin == true {
                return true
            }
        }
        return false
    } // End of func buildArray

    
    fileprivate func splitArrayAndCompare(array:[Int]) -> Bool {
        let tempArray:[Int] = array
        
        if array.count == 3 {
            if compareWithWinConditions(tempArray) == true {
                return true
            } else {
                return false
            }
            
        } else if array.count == 4 {
            // Split array into the 4 seperate array combinations, then compare each of them to one of the win condition arrays
            for i in 0..<3 {
                var splitArray:[Int] = tempArray
                splitArray.remove(at: i)
                print("Split array: \(splitArray)")
                
                if compareWithWinConditions(splitArray) == true {
                    return true
                } else {
                    return false
                }
            } // End of splitArrays for loop
        }
        print("No win conditions met")
        return false
    } // End of func splitArrayAndCompare
    
    
    fileprivate func compareWithWinConditions(_ splitArray: [Int]) -> Bool {
        for j in 0..<cellOperations.winConditions.count {
            if splitArray == cellOperations.winConditions[j] {
                print("Win condition met!")
                return true
            }
        }
        return false
    }
    
    
    
} // End of struct PlayerArrays
