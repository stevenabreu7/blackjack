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
    
    init() {
        money = NSUserDefaults.standardUserDefaults().integerForKey("money")
        if money == 0 { NSUserDefaults.standardUserDefaults().setInteger(500, forKey: "money") }
        bet = 0
        runningCount = 0
        trueCount = 0
        playerCards = [PlayingCard]()
        dealerCards = [PlayingCard]()
    }
    
}