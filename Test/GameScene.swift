//
//  GameScene.swift
//  Test
//
//  Created by Frode Solem on 7/21/17.
//  Copyright (c) 2017 Frode Solem. All rights reserved.
//

import SpriteKit
import GameplayKit

let myLabel = SKLabelNode(fontNamed:"Helvetica")

let squareSize = CGFloat(80)
let squareSpacing = squareSize + CGFloat(5)
let squareColor = UIColor.darkGray
let playerOneColor = UIColor.lightGray
let playerTwoColor = UIColor.black

var isPlayerOne = true
var gameSquares = [CGPoint?](repeating: nil, count: 9)
var playerOneSquares = [0,0,0,0,0,0,0,0,0]
var playerTwoSquares = [0,0,0,0,0,0,0,0,0]
var placedSquares = 0


class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        
        restart()
        
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        
        myLabel.text = "Hello"
        
        // Check if a square has been touched
        for touch in touches {
            let location = touch.location(in: self)
            let node : SKNode = self.atPoint(location)
            
            let index = node.name?.characters.index(of: "-")
            if (index != nil) {
                if node.name?.substring(to: (node.name?.characters.index(of: "-"))!) == "grid" {
                    myLabel.text = node.name!
                    
                    placeSquare(node)
                }
            }
        }

    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
    func drawBoard() {
        // Draw the game
        var i = 0
        
        for row in 0...2 {
            for col in 0...2 {
                let square = SKSpriteNode(color: squareColor, size: CGSize(width: squareSize, height: squareSize))
                let name = "grid-" + String(i)
                square.name = name
                square.position = CGPoint(x:self.frame.midX-squareSpacing+squareSpacing*CGFloat(col), y:self.frame.midY-squareSpacing+squareSpacing*CGFloat(row))
                self.addChild(square)
                
                // save the square locations
                gameSquares[i] = square.position
                i += 1
                
            }
        }
        
    }
    
    
    func placeSquare(_ node: SKNode) {
        // place one square when a player taps
        
        let playerColor : UIColor
        
        if isPlayerOne {
            playerColor = playerOneColor
        }
        else {
            playerColor = playerTwoColor
        }
        
        // Add a square with the players color
        let square = SKSpriteNode(color: playerColor, size: CGSize(width: squareSize, height: squareSize))
        square.name = "tapped"
        square.position = node.position
        self.addChild(square)
        
        placedSquares += 1
        isPlayerOne = !isPlayerOne
        
        saveClick(node)
        
        }
    
    
    func checkWinner(_ squares: [NSInteger]) -> Bool {
        //
        
        if (squares[0] == 1) && (squares[1] == 1) && (squares[2] == 1) {
            myLabel.text = "Hej"
            return true
        }
        
        return false
    }
    
    
    func saveClick(_ node: SKNode) {
        // save the squares placed by each player
        
        if let squareString = node.name! as? String {
            let squareInt = Int(squareString.characters.map{String($0)}[5])!
            
            if isPlayerOne {
                playerOneSquares[squareInt] = 1
            }
            else {
                playerTwoSquares[squareInt] = 1
            }
            
            print("Placed:")
            print(playerOneSquares)
            print(playerTwoSquares)
            print("----------")
        }
        
    }
    
    
    func restart() {
        // Restart the game
        
        self.removeAllChildren()
        
        myLabel.text = "Hello player"
        myLabel.fontSize = 47
        myLabel.fontColor = UIColor.darkGray
        myLabel.position = CGPoint(x:self.frame.midX, y:self.frame.midY+200)
        
        self.addChild(myLabel)
        
        drawBoard()
        
        placedSquares = 0
        playerOneSquares = [0,0,0,0,0,0,0,0,0]
        playerTwoSquares = [0,0,0,0,0,0,0,0,0]
    }
}
