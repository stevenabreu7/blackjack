//
//  Deck.swift
//  Blackjack
//
//  Created by Steven Abreu on 20/08/16.
//  Copyright © 2016 stevenabreu. All rights reserved.
//

import Foundation

class Deck {
    
    private var cards : [PlayingCard]
    private var numberOfDecks : Int
    
    init() {
        self.numberOfDecks = 0
        self.cards = [PlayingCard]()
    }
    
    init(numberOfDecks: Int) {
        self.numberOfDecks = numberOfDecks
        cards = [PlayingCard]()
        
        for _ in 1...self.numberOfDecks {
            for i in 1...52 {
                cards.append(PlayingCard(cardNumber: i))
            }
        }
    }
    
    func getRandomCard() -> PlayingCard {
        var index : Int
        index = Int(arc4random_uniform(UInt32(cards.count)))
        let card = cards[index]
        cards.removeAtIndex(index)
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