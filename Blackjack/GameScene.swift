//
//  GameScene.swift
//  Blackjack
//
//  Created by Steven Abreu on 20/08/16.
//  Copyright (c) 2016 stevenabreu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //deck
    var cardPile = Deck()
    
    //poker table background
    let bg = SKSpriteNode(imageNamed: "background_table")
    let coinPlace = SKSpriteNode(imageNamed: "background_coin")
    
    //Information labels for the game
    let bettingLabel = SKLabelNode(fontNamed: "Avenir") 
    let moneyLabel = SKLabelNode(fontNamed: "Avenir")   
    let dealerValueLabel = SKLabelNode(fontNamed: "Avenir") 
    let playerValueLabel = SKLabelNode(fontNamed: "Avenir") 
    let runningCountLabel = SKLabelNode(fontNamed: "Avenir") 
    let exitLabel = SKLabelNode(fontNamed: "Avenir") 
    let trueCountLabel = SKLabelNode(fontNamed: "Avenir")
    let handsPlayedLabel = SKLabelNode(fontNamed: "Avenir")
    let deckCountLabel = SKLabelNode(fontNamed: "Avenir")
    
    //player action labels
    let hit = SKLabelNode(fontNamed: "Avenir")
    let stand = SKLabelNode(fontNamed: "Avenir")
    let double = SKLabelNode(fontNamed: "Avenir")
    let split = SKLabelNode(fontNamed: "Avenir")
    
    //game objects
    let deck = SKSpriteNode(imageNamed: "deck")
    let coin10 = SKSpriteNode(imageNamed: "coin10") 
    let coin50 = SKSpriteNode(imageNamed: "coin50") 
    let coin100 = SKSpriteNode(imageNamed: "coin100") 
    let coin200 = SKSpriteNode(imageNamed: "coin200") 
    let betCoin10 = SKSpriteNode(imageNamed: "coin10")
    let betCoin50 = SKSpriteNode(imageNamed: "coin50")
    let betCoin100 = SKSpriteNode(imageNamed: "coin100")
    let betCoin200 = SKSpriteNode(imageNamed: "coin200")
    
    override func didMoveToView(view: SKView) {
        
        cardPile = Deck(numberOfDecks: 2)
        setupScene()
        print(NSUserDefaults.standardUserDefaults().integerForKey("money"))
        
    }
    
    func setupScene() {
        //background
        bg.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        bg.size = self.frame.size
        bg.zPosition = -1
        self.addChild(bg)
        
        //deck
        deck.size.width = self.frame.size.width / 5
        deck.size.height = deck.size.width * 1.5
        deck.position = CGPointMake(self.frame.size.width - deck.size.width * 0.8, self.frame.size.height - deck.size.height * 1.2)
        deck.zRotation = 0.2
        self.addChild(deck)
        
        //coins
        let coinSize = self.frame.size.width / 6
        let coins : [SKSpriteNode] = [coin10, coin50, coin100, coin200, betCoin10, betCoin50, betCoin100, betCoin200]
        
        for coin in coins {
            coin.size = CGSizeMake(coinSize, coinSize)
            coin.zPosition = 2
        }
        
        coin10.position = CGPointMake(coin10.size.width * 1.1, coin10.size.height * 0.75)
        coin50.position = CGPointMake(coin50.size.width * 0.6, coin50.size.height * 1.75)
        coin100.position = CGPointMake(coin100.size.width * 2.2, coin100.size.height * 0.75)
        coin200.position = CGPointMake(coin200.size.width * 1.7, coin200.size.height * 1.75)
        
        self.addChild(coin10)
        self.addChild(coin50)
        self.addChild(coin100)
        self.addChild(coin200)
        
        betCoin10.position = CGPointMake(self.frame.size.width / 2 + coin10.size.width * 1.1, coin10.size.height * 0.75)
        betCoin50.position = CGPointMake(self.frame.size.width / 2 + coin50.size.width * 0.6, coin50.size.height * 1.75)
        betCoin100.position = CGPointMake(self.frame.size.width / 2 + coin100.size.width * 2.2, coin100.size.height * 0.75)
        betCoin200.position = CGPointMake(self.frame.size.width / 2 + coin200.size.width * 1.7, coin200.size.height * 1.75)
        
        //Coinplace
        coinPlace.anchorPoint = CGPoint(x: 0, y: 0)
        coinPlace.zPosition = 1
        coinPlace.position = CGPointMake(self.frame.size.width / 2, coin50.size.height * 0.15)
        coinPlace.size.width = coin50.size.width * 2.8
        coinPlace.size.height = coin50.size.height * 2.2
        self.addChild(coinPlace)
        
        //Player Options
        hit.text = "Hit"
        hit.position.x = self.frame.size.width * 0.125
        stand.text = "Stand"
        stand.position.x = self.frame.size.width * 0.375
        double.text = "Double"
        double.position.x = self.frame.size.width * 0.625
        split.text = "Split"
        split.position.x = self.frame.size.width * 0.875
        
        for label in [hit, stand, double, split] {
            label.horizontalAlignmentMode = .Center
            label.position.y = self.frame.size.height * 0.25
            label.fontColor = SKColor.blackColor()
            label.fontSize = 22
            self.addChild(label)
        }
        
        //LABELS
        bettingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        bettingLabel.position = CGPointMake(20, self.frame.size.height - 30)
        bettingLabel.fontSize = 25
        bettingLabel.fontColor = SKColor.whiteColor()
        bettingLabel.zPosition = 1
        bettingLabel.text = "Bet: 0"
        self.addChild(bettingLabel)
        
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        moneyLabel.position = CGPointMake(self.frame.size.width / 2, self.frame.size.height - 30)
        moneyLabel.fontSize = 25
        moneyLabel.fontColor = SKColor.whiteColor()
        moneyLabel.text = "Money: " + "0"//String(money)
        moneyLabel.zPosition = 1
        self.addChild(moneyLabel)
        
        exitLabel.position = CGPointMake(deck.position.x, deck.position.y - deck.size.height)
        exitLabel.fontColor = SKColor.blackColor()
        exitLabel.fontSize = 30
        exitLabel.text = "Restart"
        self.addChild(exitLabel)
        
        dealerValueLabel.position = CGPointMake(self.frame.size.width * 0.2, deck.position.y - deck.size.height / 2 - 30)
        dealerValueLabel.fontColor = SKColor.whiteColor()
        dealerValueLabel.text = "dealer"
        dealerValueLabel.fontSize = 20
        
        self.addChild(dealerValueLabel)
        
        playerValueLabel.position = CGPointMake(self.frame.size.width * 0.4, self.frame.size.height * 0.45 - deck.size.height / 2 - 30)
        playerValueLabel.fontColor = SKColor.whiteColor()
        playerValueLabel.text = "player"
        playerValueLabel.fontSize = 20
        
        self.addChild(playerValueLabel)
        
        runningCountLabel.position = CGPointMake(deck.position.x, deck.position.y - deck.size.height * 1.5)
        runningCountLabel.fontColor = SKColor.whiteColor()
        runningCountLabel.text = "Running: " + "0"
        runningCountLabel.fontSize = 20
        self.addChild(runningCountLabel)
        
        trueCountLabel.position = CGPointMake(deck.position.x, deck.position.y - deck.size.height * 1.75)
        trueCountLabel.fontColor = SKColor.whiteColor()
        trueCountLabel.fontSize = 20
        trueCountLabel.text = "True: " + "0"//String(trueCount)
        self.addChild(trueCountLabel)
        
        handsPlayedLabel.position = CGPointMake(deck.position.x, deck.position.y - deck.size.height * 2)
        handsPlayedLabel.fontColor = SKColor.whiteColor()
        handsPlayedLabel.fontSize = 20
        handsPlayedLabel.text = "Hands: " + "0"//String(handsPlayed)
        self.addChild(handsPlayedLabel)
        
        deckCountLabel.position = CGPointMake(deck.position.x, deck.position.y - deck.size.height * 2.25)
        deckCountLabel.fontColor = SKColor.whiteColor()
        deckCountLabel.fontSize = 20
        deckCountLabel.text = "Cards: " + "0"//String(card.count)
        self.addChild(deckCountLabel)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        for touch in touches {
//            let location = touch.locationInNode(self)            
//        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
