//
//  Cards.swift
//  SingleView
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import Foundation

enum Suit {
    case Clubs, Diamonds, Hearts    // many on one line
    case Spades
}

enum Rank: Int {
    case Two = 2, Three, Four, Five
    case Six, Seven, Eight, Nine, Ten
    case Jack, Queen, King, Ace
}

enum Card {
    case Face(Rank, Suit)
    case Joker
}
