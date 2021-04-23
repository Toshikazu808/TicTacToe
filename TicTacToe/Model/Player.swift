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
    
    
    mutating func cpuRandomChoice() -> Int {
        let computerRandomChoice = Int(arc4random_uniform(9))
        print("Computer chose \(computerRandomChoice)")
        return computerRandomChoice
    } // End of func cpuRandomChoice
    
    
    // TODO: Make the computer recognize potential win condition and block
    mutating func cpuSmartChoice(p1Array:[Int], p2Array:[Int]) -> Int {

        switch p2Array { // CPU wins the game if possible
        case cellOperations.winPotential[0]:
            return 2
        case cellOperations.winPotential[1]:
            return 6
        case cellOperations.winPotential[2]:
            return 8
        case cellOperations.winPotential[3]:
            return 0
        case cellOperations.winPotential[4]:
            return 7
        case cellOperations.winPotential[5]:
            return 6
        case cellOperations.winPotential[6]:
            return 8
        case cellOperations.winPotential[7]:
            return 5
        case cellOperations.winPotential[8]:
            return 0
        case cellOperations.winPotential[9]:
            return 3
        case cellOperations.winPotential[10]:
            return 2
        case cellOperations.winPotential[11]:
            return 1
        case cellOperations.winPotential[12]:
            return 0
        case cellOperations.winPotential[13]:
            return 2
        case cellOperations.winPotential[14]:
            return 8
        case cellOperations.winPotential[15]:
            return 6
        default:
            switch p1Array { // CPU blocks Player1 win if possible
            case cellOperations.winPotential[0]:
                return 2
            case cellOperations.winPotential[1]:
                return 6
            case cellOperations.winPotential[2]:
                return 8
            case cellOperations.winPotential[3]:
                return 0
            case cellOperations.winPotential[4]:
                return 7
            case cellOperations.winPotential[5]:
                return 6
            case cellOperations.winPotential[6]:
                return 8
            case cellOperations.winPotential[7]:
                return 5
            case cellOperations.winPotential[8]:
                return 0
            case cellOperations.winPotential[9]:
                return 3
            case cellOperations.winPotential[10]:
                return 2
            case cellOperations.winPotential[11]:
                return 1
            case cellOperations.winPotential[12]:
                return 0
            case cellOperations.winPotential[13]:
                return 2
            case cellOperations.winPotential[14]:
                return 8
            case cellOperations.winPotential[15]:
                return 6
            default:
                return cpuRandomChoice()
            }
        }
        
    } // End of func cpuSmartChoice
 
    
    mutating func buildArray(player:Bool, cellTag:Int) -> Bool {
        if player == true { // Build array for Player 1
            player1Array.append(cellTag)
            player1Array.sort()
            print("Player1 Array: \(player1Array)")
            
            let didWin = splitArrayAndCompare(array: player1Array)
            if didWin == true {
                return true
            }

        } else { // Build array for Player 2
            
            
            
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
        } else if array.count > 3 {
            // Splits array into all combinations, then compares each of them to winConditions
            for i in 0...(array.count - 1) {
                var splitArray:[Int] = tempArray
                splitArray.remove(at: i)
                print("First split array: \(splitArray)")
                if compareWithWinConditions(splitArray) == true {
                    return true
                }
                
                for j in 0...(splitArray.count - 1) {
                    var secondSplitArray:[Int] = splitArray
                    secondSplitArray.remove(at: j)
                    print("Second split array: \(secondSplitArray)")
                    if compareWithWinConditions(secondSplitArray) == true {
                        return true
                    }
                } // End of nested split loop
            } // End of first split loop
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
