//
//  SetCardGame.swift
//  NewSetCardGame
//
//  Created by ENRAG3DCHICKEN on 2020-08-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import Foundation

struct SetGame<CardContent> {
    
    private var deck: Array<Card>
    private(set) var cards: Array<Card>
    
    private var faceUpCards: Array<Card> = []
    

    init(SetDeck: [SetCard]) {
        cards = Array<Card>()
        deck = Array<Card>()
        
        //Append the Original 81 Cards into the deck
        for items in SetDeck {
            deck.append(Card(id: items.id!, number: items.number, symbol: items.symbol as! CardContent, shading: items.shading, color: items.color))
        }

        //Take the Original 12 Cards from the Deck and Transfer them to Cards Array
        for _ in 0..<12 {
            let randomInteger = Int.random(in: 0..<deck.count)
            cards.append(deck[randomInteger])
            deck.remove(at: randomInteger)
        }
            
            
            
        
    }
    
    mutating func addCards() {
        for _ in 0..<3 {
            let randomInteger = Int.random(in: 0..<deck.count)
            self.cards.append(deck[randomInteger])
            self.deck.remove(at: randomInteger)
        }
    }
    
    mutating func choose(card: Card) {
        print("card chose: \(card)")
        
        //Determine if the card select is the first card, second card, or third card
        
        
        
    }
    
    
    struct Card: Identifiable {

        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var id: Int
        
        var number: Int?
        var symbol: CardContent
        var shading: String?
        var color: String?
        
    }
}
