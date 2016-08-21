//
//  PlayingCard.swift
//  Blackjack
//
//  Created by Steven Abreu on 20/08/16.
//  Copyright © 2016 stevenabreu. All rights reserved.
//

import Foundation

class PlayingCard {
    
    private var cardNumber : Int    //absolute number of card (1 - 52)
    
    private var suit : Int          //0 - spades, 1 - hearts, 2 - diamonds, 3 - clubs
    private var rank : Int          //1 - ace, 11 - jack, 12 - queen, 13 - king
    private var value : Int         //blackjack value of cards (ace counts as 11)
    
    init(cardNumber : Int) {
        self.cardNumber = cardNumber
        self.suit = Int(floor(Double(cardNumber - 1) / Double(13)))
        self.rank = cardNumber - (suit * 13)
        if (self.rank == 1) {
            self.value = 11
        } else if (self.rank > 10) {
            self.value = 10
        } else {
            self.value = self.rank
        }
    }
    
    //--------public get methods--------
    
    func getSuit() -> Int {
        return suit
    }
    
    func getRank() -> Int {
        return rank
    }
    
    func getValue() -> Int {
        return value
    }
}