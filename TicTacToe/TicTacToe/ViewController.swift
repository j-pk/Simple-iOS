//
//  ViewController.swift
//  TicTacToe
//
//  Created by jpk on 5/8/15.
//  Copyright (c) 2015 Parker Kirby. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var player1Score: UILabel!
    @IBOutlet weak var player1Points: UILabel!
    @IBOutlet weak var player2Points: UILabel!
    @IBOutlet var boardSpace: UIView!
    @IBOutlet weak var player1ScoreKeeper: UILabel!
    @IBOutlet weak var player2ScoreKeeper: UILabel!
    @IBOutlet weak var playerTurn: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var button1: TicButton!
    @IBOutlet weak var button2: TicButton!
    @IBOutlet weak var button3: TicButton!
    @IBOutlet weak var button4: TicButton!
    @IBOutlet weak var button5: TicButton!
    @IBOutlet weak var button6: TicButton!
    @IBOutlet weak var button7: TicButton!
    @IBOutlet weak var button8: TicButton!
    @IBOutlet weak var button9: TicButton!
    
    var player1Point: Int = 0
    var player2Point: Int = 0
   
    var winnerWon: Bool = false
    
    var spaces: [[Player?]] = [
    
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
    
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        player1Score.hidden = true
        resetButton.hidden = true
    }
    
    var currentPlayer: Player = .One
    
    @IBAction func buttonPressed(sender: TicButton) {
        
        if winnerWon == false {
            
            //if button is pressed it retains the color
            if sender.player != nil { return }
            
            //"button" player is current and draw rect on tic button
            sender.player = currentPlayer
            sender.setNeedsDisplay()
            
            //recording the row and the column from input under current player
            spaces[sender.row][sender.col] = currentPlayer
            
            println(spaces)
            
            checkForWinner()
            
            //alternates the color of the button between players
            currentPlayer = currentPlayer == .One ? .Two : .One
            
            if currentPlayer == .One {
                playerTurn.backgroundColor = UIColor(red:1, green:0.76, blue:0.26, alpha:1)
            }
            if currentPlayer == .Two {
                playerTurn.backgroundColor = UIColor(red:0, green:1, blue:0.72, alpha:1)
            }
            
        }
        
//        else {
//            println("Sorry, but there has already been a winner")
//            player1Score.hidden = false
//            
//        }
    }
    
    @IBAction func resetButton(sender: UIButton) {
        
        resetGame()
        resetButton.hidden = true
        player1Score.hidden = true
        playerTurn.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1)
        
    }
    
    func resetGame() {
        
        button1.player = nil
        button1.setNeedsDisplay()
        button2.player = nil
        button2.setNeedsDisplay()
        button3.player = nil
        button3.setNeedsDisplay()
        button4.player = nil
        button4.setNeedsDisplay()
        button5.player = nil
        button5.setNeedsDisplay()
        button6.player = nil
        button6.setNeedsDisplay()
        button7.player = nil
        button7.setNeedsDisplay()
        button8.player = nil
        button8.setNeedsDisplay()
        button9.player = nil
        button9.setNeedsDisplay()
        
        spaces = [
        
        [nil, nil, nil],
        [nil, nil, nil],
        [nil, nil, nil]
        
        ]
        
        winnerWon = false
        
    }
    
    //all the possibilities in winning
    var possibilities: [[Int]] = [
        [0,0,0,1,0,2],
        [1,0,1,1,1,2],
        [2,0,2,1,2,2],
        [0,0,1,0,2,0],
        [0,1,1,1,2,1],
        [0,2,1,2,2,2],
        [0,0,1,1,2,2],
        [0,2,1,1,2,0]
    ]
    
    func endGame() {
        
        winnerWon = true
        
    }

    func checkForWinner() {

        for possibility in possibilities {
            
            let firstSpot = spaces[possibility[0]][possibility[1]]
            let secondSpot = spaces[possibility[2]][possibility[3]]
            let thirdSpot = spaces[possibility[4]][possibility[5]]
            
            
            if  firstSpot == secondSpot && secondSpot == thirdSpot {
                
                let winner = spaces[0][0]
                
                
                if let winner = firstSpot {
                    
                    println("Player \(winner.hashValue + 1) Wins")
                    
                    player1Score.text = "Player \(winner.hashValue + 1) Wins!"
                    
                    if winner.hashValue + 1 == 1 {
                        player1Point++
                    }
                    if winner.hashValue + 1 == 2 {
                        player2Point++
                    }
                    
                    player1ScoreKeeper.text = "\(player1Point)"
                    player2ScoreKeeper.text = "\(player2Point)"
                    
                    resetButton.hidden = false
                    
                    endGame()
                
                }
                
            }
    
        }
    
    }
   
}
