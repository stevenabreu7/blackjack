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
    var model = GameModel()
    
    //poker table background
    let bg = SKSpriteNode(imageNamed: "background_table")
    let coinPlace = SKSpriteNode(imageNamed: "background_coin")
    
    //Information labels for the game
    let bettingLabel = SKLabelNode(fontNamed: "Avenir") 
    let moneyLabel = SKLabelNode(fontNamed: "Avenir")   
    let dealerValueLabel = SKLabelNode(fontNamed: "Avenir") 
    let playerValueLabel = SKLabelNode(fontNamed: "Avenir") 
    let runningCountLabel = SKLabelNode(fontNamed: "Avenir") 
    let restartLabel = SKLabelNode(fontNamed: "Avenir") 
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
    
    //CONSTANTS
    let ANIMATION_DURATION = TimeInterval(0.5)
    
    override func didMove(to view: SKView) {
        
        cardPile = Deck(numberOfDecks: 2)
        model = GameModel()
        
        setupScene()
    }
    
    func setupScene() {
        //background
        bg.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        bg.size = self.frame.size
        bg.zPosition = -1
        self.addChild(bg)
        
        //deck
        deck.size.width = self.frame.size.width / 5
        deck.size.height = deck.size.width * 1.5
        deck.position = CGPoint(x: self.frame.size.width - deck.size.width * 0.8, y: self.frame.size.height - deck.size.height * 1.2)
        deck.zRotation = 0.2
        self.addChild(deck)
        
        //coins
        let coinSize = self.frame.size.width / 6
        let coins : [SKSpriteNode] = [coin10, coin50, coin100, coin200, betCoin10, betCoin50, betCoin100, betCoin200]
        
        for coin in coins {
            coin.size = CGSize(width: coinSize, height: coinSize)
            coin.zPosition = 2
        }
        
        coin10.position = CGPoint(x: coin10.size.width * 1.1, y: coin10.size.height * 0.75)
        coin50.position = CGPoint(x: coin50.size.width * 0.6, y: coin50.size.height * 1.75)
        coin100.position = CGPoint(x: coin100.size.width * 2.2, y: coin100.size.height * 0.75)
        coin200.position = CGPoint(x: coin200.size.width * 1.7, y: coin200.size.height * 1.75)
        
        self.addChild(coin10)
        self.addChild(coin50)
        self.addChild(coin100)
        self.addChild(coin200)
        
        hideCoinsAsAppropriate()
        
        betCoin10.position = CGPoint(x: self.frame.size.width / 2 + coin10.size.width * 1.1, y: coin10.size.height * 0.75)
        betCoin50.position = CGPoint(x: self.frame.size.width / 2 + coin50.size.width * 0.6, y: coin50.size.height * 1.75)
        betCoin100.position = CGPoint(x: self.frame.size.width / 2 + coin100.size.width * 2.2, y: coin100.size.height * 0.75)
        betCoin200.position = CGPoint(x: self.frame.size.width / 2 + coin200.size.width * 1.7, y: coin200.size.height * 1.75)
        
        //Coinplace
        coinPlace.anchorPoint = CGPoint(x: 0, y: 0)
        coinPlace.zPosition = 1
        coinPlace.position = CGPoint(x: self.frame.size.width / 2, y: coin50.size.height * 0.15)
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
            label.horizontalAlignmentMode = .center
            label.position.y = self.frame.size.height * 0.25
            label.fontColor = SKColor.black
            label.fontSize = 22
        }
        
        //LABELS
        bettingLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        bettingLabel.position = CGPoint(x: 20, y: self.frame.size.height - 30)
        bettingLabel.fontSize = 25
        bettingLabel.fontColor = SKColor.white
        bettingLabel.zPosition = 1
        bettingLabel.text = "Bet: 0"
        self.addChild(bettingLabel)
        
        moneyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        moneyLabel.position = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height - 30)
        moneyLabel.fontSize = 25
        moneyLabel.fontColor = SKColor.white
        moneyLabel.text = "Money: " + String(model.money)
        moneyLabel.zPosition = 1
        self.addChild(moneyLabel)
        
        restartLabel.position = CGPoint(x: deck.position.x, y: deck.position.y - deck.size.height)
        restartLabel.fontColor = SKColor.black
        restartLabel.fontSize = 30
        restartLabel.text = "Restart"
        self.addChild(restartLabel)
        
        dealerValueLabel.position = CGPoint(x: self.frame.size.width * 0.2, y: deck.position.y - deck.size.height / 2 - 30)
        dealerValueLabel.fontColor = SKColor.white
        dealerValueLabel.text = "dealer"
        dealerValueLabel.fontSize = 20
        
        playerValueLabel.position = CGPoint(x: self.frame.size.width * 0.4, y: self.frame.size.height * 0.45 - deck.size.height / 2 - 30)
        playerValueLabel.fontColor = SKColor.white
        playerValueLabel.text = "player"
        playerValueLabel.fontSize = 20
        
        runningCountLabel.position = CGPoint(x: deck.position.x, y: deck.position.y - deck.size.height * 1.5)
        runningCountLabel.fontColor = SKColor.white
        runningCountLabel.text = "Running: " + "0"
        runningCountLabel.fontSize = 20
//        self.addChild(runningCountLabel)
        
        trueCountLabel.position = CGPoint(x: deck.position.x, y: deck.position.y - deck.size.height * 1.75)
        trueCountLabel.fontColor = SKColor.white
        trueCountLabel.fontSize = 20
        trueCountLabel.text = "True: " + String(model.trueCount)
//        self.addChild(trueCountLabel)
        
        handsPlayedLabel.position = CGPoint(x: deck.position.x, y: deck.position.y - deck.size.height * 2)
        handsPlayedLabel.fontColor = SKColor.white
        handsPlayedLabel.fontSize = 20
//        handsPlayedLabel.text = "Hands: " + String(handsPlayed)
//        self.addChild(handsPlayedLabel)
        
        deckCountLabel.position = CGPoint(x: deck.position.x, y: deck.position.y - deck.size.height * 2.25)
        deckCountLabel.fontColor = SKColor.white
        deckCountLabel.fontSize = 20
//        deckCountLabel.text = "Cards: " + String(card.count)
//        self.addChild(deckCountLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            setBets(location)
            if atPoint(location) == deck {
                firstDeal()
            }
            playerOptions(location)
            if atPoint(location) == restartLabel {
                model.money += model.bet
                restartGame()
            }
        }
    }
    
    func playerOptions(_ location: CGPoint) {
        if atPoint(location) == hit {
            playerHits()
        } else if atPoint(location) == stand {
            playerStands()
        } else if atPoint(location) == double {
            playerDoubles()
        }
    }
    
    func playerHits() {
        if model.getPlayerValue() < 22 {
            dealPlayer()
            if model.didPlayerBust() {
                self.run(SKAction.sequence([SKAction.wait(forDuration: ANIMATION_DURATION), SKAction.run({ self.playerBusted() })]))
            }
            playerValueLabel.text = String(model.getPlayerValue())
        } else {
            _ = model.didPlayerBust()
        }
    }
    
    func playerStands() {
        //turn dealers first card
        let cardSprite = SKSpriteNode(imageNamed: model.dealerCards[0].getImageName())
        cardSprite.size = deck.size
        cardSprite.position = self.childNode(withName: "dealer0")!.position
        cardSprite.zPosition = 1
        self.childNode(withName: "dealer0")?.removeFromParent()
        cardSprite.name = "dealer0"
        self.addChild(cardSprite)
        //update dealer value label
        model.dealersTurn()
        dealerValueLabel.text = String(model.getDealerValue())
        
        //get as many cards as necessary
        dealerWorkflow()
    }
    
    func dealerWorkflow() {
        let waitAction = SKAction.wait(forDuration: ANIMATION_DURATION)
        let dealDealerAction = SKAction.run({
            self.dealDealer()
        })
        let dealAndWaitSequence = SKAction.sequence([dealDealerAction, waitAction])
        
        if model.getDealerValue() < 17 {
            self.run(dealAndWaitSequence, completion: {_ in self.dealerWorkflow()})
        } else {
            self.run(SKAction.wait(forDuration: (ANIMATION_DURATION * 2)), completion: {_ in self.showdown()})
        }
    }
    
    func showdown() {
        if model.getDealerValue() > 21 {
            playerWon()
        } else {
            if (model.getDealerValue() > model.getPlayerValue()) {
                playerLost()
            } else if (model.getDealerValue() == model.getPlayerValue()) {
                draw()
            } else {
                playerWon()
            }
        }
    }
    
    func playerWon() {
        model.money += model.bet * 2
        
        let bettedCoins = [betCoin10, betCoin50, betCoin100, betCoin200]
        let coinImageNames = ["coin10", "coin50", "coin100", "coin200"]
        
        for coinName in coinImageNames {
            if (model.amountOfCoins[coinName] != 0) {
                let coin = bettedCoins[coinImageNames.index(of: coinName)!]
                
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: (-1 * self.frame.midX), dy: 0), duration: ANIMATION_DURATION)
                coin.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]), completion: {_ in self.restartGame()})
            }
        }
        
//        showDialog("You won", message: "Win.", handler: {_ in self.restartGame()})
    }
    
    func draw() {
        model.money += model.bet
        
        let bettedCoins = [betCoin10, betCoin50, betCoin100, betCoin200]
        let coinImageNames = ["coin10", "coin50", "coin100", "coin200"]
        
        for coinName in coinImageNames {
            if (model.amountOfCoins[coinName] != 0) {
                let coin = bettedCoins[coinImageNames.index(of: coinName)!]
                
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: (-1 * self.frame.midX), dy: 0), duration: ANIMATION_DURATION)
                coin.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]), completion: {_ in self.restartGame()})
            }
        }
        
//        showDialog("It's a draw", message: "Draw.", handler: {_ in self.restartGame()})
    }
    
    func playerLost() {
        model.bet = 0
        if model.money == 0 {
            model.money = 500
        }
        
        let bettedCoins = [betCoin10, betCoin50, betCoin100, betCoin200]
        let coinImageNames = ["coin10", "coin50", "coin100", "coin200"]
        
        for coinName in coinImageNames {
            if (model.amountOfCoins[coinName] != 0) {
                let coin = bettedCoins[coinImageNames.index(of: coinName)!]
                
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: self.frame.midX, dy: 0), duration: ANIMATION_DURATION)
                coin.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]), completion: {_ in self.restartGame()})
            }
        }
        
//        showDialog("You lost", message: "Lose.", handler: {_ in self.restartGame()})
    }
    
    func playerDoubles() {
        if (model.playerCards.count == 2) {
            model.money -= model.bet
            model.bet *= 2
            playerHits()
            playerStands()
        }
    }
    
    func playerBusted() {
//        showDialog("Busted!", message: "You lose.", handler: {_ in self.restartGame()})
        
        let bettedCoins = [betCoin10, betCoin50, betCoin100, betCoin200]
        let coinImageNames = ["coin10", "coin50", "coin100", "coin200"]
        
        for coinName in coinImageNames {
            if (model.amountOfCoins[coinName] != 0) {
                let coin = bettedCoins[coinImageNames.index(of: coinName)!]
                
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: self.frame.midX, dy: 0), duration: ANIMATION_DURATION)
                coin.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]), completion: {_ in self.restartGame()})
            }
        }
        
        gameOver()
    }
    
    func restartGame() {
        //clear bet
        model.bet = 0
        //clear coins
        for coin in [betCoin10, betCoin50, betCoin100, betCoin200] {
            coin.removeFromParent()
        }
        //clear cards
        for card in model.playedCards {
            self.childNode(withName: card)?.removeFromParent()
        }
        //clear value labels
        playerValueLabel.removeFromParent()
        dealerValueLabel.removeFromParent()
        //remove player options
        for node in [hit, stand, double] {
            node.removeFromParent()
        }
        //reset model
        model.restartGame()
        //reset bet coin position
        betCoin10.position = CGPoint(x: self.frame.size.width / 2 + coin10.size.width * 1.1, y: coin10.size.height * 0.75)
        betCoin50.position = CGPoint(x: self.frame.size.width / 2 + coin50.size.width * 0.6, y: coin50.size.height * 1.75)
        betCoin100.position = CGPoint(x: self.frame.size.width / 2 + coin100.size.width * 2.2, y: coin100.size.height * 0.75)
        betCoin200.position = CGPoint(x: self.frame.size.width / 2 + coin200.size.width * 1.7, y: coin200.size.height * 1.75)
        //hide coins
        hideCoinsAsAppropriate()
    }
    
    func playerBlackjack() {
        model.money += Int(round(Double(model.bet) * 1.5))
        model.money -= model.money % 10
        showDialog("Blackjack!", message: "", handler: {_ in self.restartGame()})
        gameOver()
    }
    
    func gameOver() {
        UserDefaults.standard.set(model.money, forKey: "money")
    }
    
    func setBets(_ location: CGPoint) {
        let availableCoins = [coin10, coin50, coin100, coin200]
        let bettedCoins = [betCoin10, betCoin50, betCoin100, betCoin200]
        let coinImageNames = ["coin10", "coin50", "coin100", "coin200"]
        let coinValues = [10, 50, 100, 200]
        
        if (!model.playerCards.isEmpty) {
            return
        }
        
        for index in 0...(availableCoins.count - 1) {
            if atPoint(location) == availableCoins[index] && model.money >= coinValues[index] {
                //set money and bet in model
                model.bet += coinValues[index]
                model.money -= coinValues[index]
                //add coin to screen
                let coinSprite = SKSpriteNode(imageNamed: coinImageNames[index])
                coinSprite.size = coin10.size
                coinSprite.position = availableCoins[index].position
                coinSprite.zPosition = coinPlace.zPosition + 1 + CGFloat(model.amountOfCoins[coinImageNames[index]]!)
                self.addChild(coinSprite)
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: self.frame.midX, dy: 0), duration: ANIMATION_DURATION)
                let addRealCoin = SKAction.run({ self.addChild(bettedCoins[index]) })
                if (model.amountOfCoins[coinImageNames[index]]! > 0) {
                    coinSprite.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]))
                } else {
                    coinSprite.run(SKAction.sequence([moveCoinAnimation, addRealCoin, SKAction.removeFromParent()]), completion: {_ in print(bettedCoins[index])})
                }
                model.amountOfCoins[coinImageNames[index]]! += 1
            }
        }
        for index in 0...(bettedCoins.count - 1) {
            if atPoint(location) == bettedCoins[index] {
                //set money and bet in model
                model.bet -= coinValues[index]
                model.money += coinValues[index]
                //add coin to screen
                let coinSprite = SKSpriteNode(imageNamed: coinImageNames[index])
                coinSprite.size = coin10.size
                coinSprite.position = bettedCoins[index].position
                coinSprite.zPosition = 3
                self.addChild(coinSprite)
                //animate coin
                let moveCoinAnimation = SKAction.move(by: CGVector(dx: -1 * self.frame.midX, dy: 0), duration: ANIMATION_DURATION)
                coinSprite.run(SKAction.sequence([moveCoinAnimation, SKAction.removeFromParent()]))
                //update coins, remove from screen if needed
                model.amountOfCoins[coinImageNames[index]]! -= 1
                if model.amountOfCoins[coinImageNames[index]]! == 0 {
                    bettedCoins[index].removeFromParent()
                }
            }
        }
        hideCoinsAsAppropriate()
    }
    
    func hideCoinsAsAppropriate() {
        coin10.isHidden = false;
        coin50.isHidden = false;
        coin100.isHidden = false;
        coin200.isHidden = false;
        if model.money >= 200 {
            //show all
        } else if model.money >= 100 {
            //hide 200
            coin200.isHidden = true;
        } else if model.money >= 50 {
            //hide 100
            coin100.isHidden = true;
            coin200.isHidden = true;
        } else if model.money >= 10 {
            //hide 50
            coin50.isHidden = true;
            coin100.isHidden = true;
            coin200.isHidden = true;
        } else {
            //hide all
            coin10.isHidden = true;
            coin50.isHidden = true;
            coin100.isHidden = true;
            coin200.isHidden = true;
        }
    }
    
    func dealCard(_ cardPosition: CGPoint, dealPlayer: Bool, cardName: String) {
        
        let cardDrawn = cardPile.getRandomCard()
        var cardZPosition = CGFloat()
        
        if dealPlayer {
            model.playerCards.append(cardDrawn)
            cardZPosition = CGFloat(model.playerCards.count)
        } else {
            model.dealerCards.append(cardDrawn)
            cardZPosition = CGFloat(model.dealerCards.count)
        }
        model.playedCards.append(cardName)
        
        //make card
        let cardSprite = (!dealPlayer && model.dealerCards.count == 1) ? SKSpriteNode(imageNamed: "cardb") : SKSpriteNode(imageNamed: cardDrawn.getImageName())
        cardSprite.size = deck.size
        cardSprite.position = deck.position
        cardSprite.zPosition = cardZPosition
        cardSprite.name = cardName
        self.addChild(cardSprite)
        //animate
        let animation = SKAction.move(to: cardPosition, duration: ANIMATION_DURATION)
        cardSprite.run(animation)
        //update count
        if !(!dealPlayer && model.dealerCards.count == 1) {
            model.updateCount(cardDrawn)
        }
        //update value labels
        playerValueLabel.text = String(model.getPlayerValue())
        dealerValueLabel.text = String(model.getDealerValue())
        
        print(model.playedCards.count)
    }
    
    func dealPlayer() {
        let playerPosition = CGPoint(x: self.frame.size.width * 0.4 + CGFloat(20 * model.playerCards.count), y: self.frame.size.height * 0.45 + CGFloat(20 * model.playerCards.count))
        dealCard(playerPosition, dealPlayer: true, cardName: "player" + String(model.playerCards.count))
    }
    
    func dealDealer() {
        let dealerPosition = CGPoint(x: self.frame.size.width * 0.2 + CGFloat(20 * model.dealerCards.count), y: deck.position.y)
        dealCard(dealerPosition, dealPlayer: false, cardName: "dealer" + String(model.dealerCards.count))
    }
    
    func firstDeal() {
        if model.bet == 0 {
            showDialog("Set Bets", message: "Please set your bets before starting to deal.", handler: nil)
            return
        }
        let playerAction = SKAction.run({self.dealPlayer()})
        let dealerAction = SKAction.run({self.dealDealer()})
        let waitAction = SKAction.wait(forDuration: ANIMATION_DURATION)
        let showDecisions = SKAction.run({
//            TODO: split implementieren
//            for node in [self.hit, self.stand, self.split, self.double, self.playerValueLabel, self.dealerValueLabel] {
            for node in [self.hit, self.stand, self.double, self.playerValueLabel, self.dealerValueLabel] {
                self.addChild(node)
            }
        })
        let checkBlackjack = SKAction.run({
            if self.model.getPlayerValue() == 21 {
                self.playerBlackjack()
            }
        })
        self.run(SKAction.sequence([playerAction, waitAction, dealerAction, waitAction, playerAction, waitAction, dealerAction, waitAction, showDecisions, checkBlackjack]))
    }
   
    override func update(_ currentTime: TimeInterval) {
        moneyLabel.text = "Money: " + String(model.money)
        bettingLabel.text = "Bet: " + String(model.bet)
    }
    
    //HELPER
    
    func showDialog(_ title: String, message: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertController.addAction(okAction)
        self.view?.window?.rootViewController!.present(alertController, animated: true, completion: nil)
    }
}
