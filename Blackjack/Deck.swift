//
//  Deck.swift
//  Blackjack
//
//  Created by Steven Abreu on 20/08/16.
//  Copyright © 2016 stevenabreu. All rights reserved.
//

import Foundation

class Deck {
    
    fileprivate var cards : [PlayingCard]
    fileprivate var numberOfDecks : Int
    var model: GameModel
    
    init() {
        self.model = GameModel()
        self.numberOfDecks = 0
        self.cards = [PlayingCard]()
    }
    
    init(numberOfDecks: Int) {
        self.model = GameModel()
        self.numberOfDecks = numberOfDecks
        self.cards = [PlayingCard]()
        
        for _ in 1...self.numberOfDecks {
            for i in 1...52 {
                cards.append(PlayingCard(cardNumber: i))
            }
        }
    }
    
    func getRandomCard() -> PlayingCard {
        var index : Int
        index = Int(arc4random_uniform(UInt32(cards.count)))
        if cards.count == 0 {
            reshuffleDeck()
        }
        let card = cards[index]
        model.updateCount(card)
        cards.remove(at: index)
        return card
    }
    
    func reshuffleDeck() {
        self.cards = [PlayingCard]()
        for _ in 1...self.numberOfDecks {
            for i in 1...52 {
                cards.append(PlayingCard(cardNumber: i))
            }
        }
    }
}
