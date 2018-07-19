//
//  CardsTest.swift
//  SingleViewTests
//
//  Created by dfang on 2018-7-23.
//  Copyright © 2018年 east. All rights reserved.
//

import XCTest

class CardsTest: XCTestCase {
    
    func testSuit() {
        XCTAssertEqual(Suit.Clubs, .Clubs, "clubs equal")
    }
    
    func testRank() {
        XCTAssertEqual(Rank.Two.rawValue, 2, "Rank.Tow.rawValue is 2")
        XCTAssertEqual(Rank(rawValue: 6)!,  Rank.Six, "Rank(rawValue:6)! == Rank.Six")
        XCTAssertEqual(Rank(rawValue: 14)!,  Rank.Ace, "Rank(rawValue:14)! equal Rank.Ace")
        XCTAssertEqual(Rank(rawValue: 15),  nil, "Rank(rawValue:15) is nil")
    }
    
    func testCard() {
        let aceOfSpades:Card = Card.Face(Rank.Ace, Suit.Spades)
        let joker:Card = Card.Joker
        
        var jokerSeen = false
        var aceOfSpadesSeen = false
        for card in [aceOfSpades, joker] {
            switch (card) {
            case Card.Face(Rank.Ace, Suit.Spades):
                aceOfSpadesSeen = true
            case .Face(let rank, let suit):
                XCTFail("Saw a card \(rank) of \(suit)")
            case .Joker:
                jokerSeen = true
            }
        }
        XCTAssert(aceOfSpadesSeen)
        XCTAssert(jokerSeen)
    }
    
}
