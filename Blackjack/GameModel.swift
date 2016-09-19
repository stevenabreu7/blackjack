//
//  GameModel.swift
//  Blackjack
//
//  Created by Steven Abreu on 21/08/16.
//  Copyright © 2016 stevenabreu. All rights reserved.
//

import Foundation
import Realm

class GameModel {
    
    var money : Int
    var bet : Int
    var runningCount : Int
    var trueCount : Int
    var playerCards : [PlayingCard]
    var dealerCards : [PlayingCard]
    var amountOfCoins = ["coin10" : 0, "coin50" : 0, "coin100" : 0, "coin200" : 0]
    var playedCards : [String]
    var dealersFirstCardTurned : Bool
    
    init() {
        money = UserDefaults.standard.integer(forKey: "money")
        if money == 0 { UserDefaults.standard.set(500, forKey: "money") }
        bet = 0
        runningCount = 0
        trueCount = 0
        playerCards = [PlayingCard]()
        dealerCards = [PlayingCard]()
        playedCards = [String]()
        dealersFirstCardTurned = false
    }
    
    func updateCount(_ withCard: PlayingCard) {
        
    }
    
    func dealersTurn() {
        dealersFirstCardTurned = true
    }
    
    func getPlayerValue() -> Int {
        var playerValue = 0
        for card in playerCards {
            playerValue += card.getValue()
        }
        return playerValue
    }
    
    func getDealerValue() -> Int {
        var dealerValue = 0
        for card in dealerCards {
            dealerValue += (card.isEqualTo(dealerCards[0]) && !dealersFirstCardTurned) ? 0 : card.getValue()
        }
        if dealerValue > 21 {
            var aces = [PlayingCard]()
            for card in dealerCards {
                if card.getValue() == 11 {
                    aces.append(card)
                }
            }
            if !aces.isEmpty {
                aces[0].changeAceValue()
                dealerValue -= 10
            }
        }
        return dealerValue
    }
    
    func didPlayerBust() -> Bool {
        if getPlayerValue() < 22 {
            return false
        } else {
            var aces = [PlayingCard]()
            for card in playerCards {
                if card.getValue() == 11 {
                    aces.append(card)
                }
            }
            while getPlayerValue() > 21 {
                if !aces.isEmpty {
                    aces.first!.changeAceValue()
                } else {
                    return true
                }
            }
            return false
        }
    }
    
    func restartGame() {
        runningCount = 0
        trueCount = 0
        playerCards = [PlayingCard]()
        dealerCards = [PlayingCard]()
        amountOfCoins = ["coin10" : 0, "coin50" : 0, "coin100" : 0, "coin200" : 0]
        playedCards = [String]()
        dealersFirstCardTurned = false
    }
}
