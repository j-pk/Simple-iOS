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
        player1Score.backgroundColor = UIColor(red:0.0, green:0.0, blue:0.0, alpha:0)
        
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
            
        } else {
            println("Sorry, but there has already been a winner")
            player1Score.textColor = UIColor(red:0.16, green:0.17, blue:0.2, alpha:1)
            playerTurn.backgroundColor = UIColor(red:1, green:1, blue:1, alpha:1)
            
     
        }
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
                    
                    
                    endGame()
                    
                
                }
                
            }
    
        }
    
    }
   
}


/*      //comparing if the array values are true
var player1Win = spaces[0][0] == spaces[0][1] && spaces [0][1] == spaces[0][2] && spaces[0][0] == .One

var player2Win = spaces[0][0] == spaces[0][1] && spaces [0][1] == spaces[0][2] && spaces[0][0] == .Two

for view in self.view.subviews {

view.removeFromSuperView()


*/