//
//  CellOperations.swift
//  TicTacToe
//
//  Created by Ryan Kanno on 5/29/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import Foundation

struct CellOperations {
    
    var cellWasTapped:[Bool] = [
        false, false, false,
        false, false, false,
        false, false, false] // true is tapped, false is not tapped
       
    let winConditions:[[Int]] = [
        [0, 1, 2], [0, 3, 6], [0, 4, 8],
        [1, 4, 7], [2, 5, 8], [2, 4, 6],
        [3, 4, 5], [6, 7, 8]
    ]
        
    let winPotential:[[Int]] = [
        [0, 1], [0, 3], [0, 4],
        [1, 2], [1, 4],
        [2, 4], [2, 5],
        [3, 4], [3, 6],
        [4, 5], [4, 6], [4, 7], [4, 8],
        [5, 8],
        [6, 7],
        [7, 8]
    ]
    
} // End of struct CellOperations

