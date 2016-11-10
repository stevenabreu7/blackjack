//
//  PlayingCard.swift
//  Blackjack
//
//  Created by Steven Abreu on 20/08/16.
//  Copyright © 2016 stevenabreu. All rights reserved.
//

import Foundation

class PlayingCard {
    
    fileprivate var cardNumber : Int    //absolute number of card (1 - 52)
    
    fileprivate var suit : Int          //0 - spades, 1 - hearts, 2 - diamonds, 3 - clubs
    fileprivate var rank : Int          //1 - ace, 11 - jack, 12 - queen, 13 - king
    fileprivate var value : Int         //blackjack value of cards (ace counts as 11)
    
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
    
    func changeAceValue() {
        if rank == 1 {
            value = 1
        }
    }
    
    func getOmegaIICount() -> Int {
        if value == 2 || value == 3 || value == 7 {
            return 1
        } else if value == 4 || value == 5 || value == 6 {
            return 2
        } else if value == 9 {
            return -1
        } else if value == 10 {
            return -2
        } else {
            return 0
        }
    }
    
    func getAbsoluteCardNumber() -> Int {
        return cardNumber
    }
    
    func isEqualTo(_ card: PlayingCard) -> Bool {
        return card.getAbsoluteCardNumber() == getAbsoluteCardNumber()
    }
    
    func getImageName() -> String {
        switch suit {
        case 0:
            return "Spades " + String(rank)
        case 1:
            return "Hearts " + String(rank)
        case 2:
            return "Diamonds " + String(rank)
        case 3:
            return "Clubs " + String(rank)
        default:
            print("ERROR getting card image name.")
            print(String(suit) + " " + String(rank) + " " + String(cardNumber))
            return ""
        }
    }
}
