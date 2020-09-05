//
//  SetCardGame.swift
//  NewSetCardGame
//
//  Created by ENRAG3DCHICKEN on 2020-08-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import Foundation

struct SetGame<CardContent> where CardContent: Equatable {
    
    private var deck: Array<Card>
    private(set) var cards: Array<Card>
    
    private var faceUpCards: Array<Card> = []
    private var match: [Bool] = [false, false, false,false]
    
    

    init(SetDeck: [SetCard]) {
        cards = Array<Card>()
        deck = Array<Card>()
        
        //Append the Original 81 Cards into the deck
        for items in SetDeck {
            deck.append(Card(id: items.id!, number: items.number, symbol: items.symbol as! CardContent, shading: items.shading, color: items.color))
        }

        //Take the Original 12 Cards from the Deck and Transfer them to Cards Array
        for counter in 0..<12 {
            let randomInteger = Int.random(in: 0..<deck.count)
            cards.append(deck[randomInteger])
            deck.remove(at: randomInteger)
            
            cards[counter].isOnScreen = true
        }
    }
    
    mutating func addCards() {
        if deck.count >= 3 {
            for _ in 0..<3 {
                let randomInteger = Int.random(in: 0..<deck.count)
                self.cards.append(deck[randomInteger])
                self.deck.remove(at: randomInteger)
                
                cards[(cards.count-1)].isOnScreen = true
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chose: \(card)")
        
        // Store the Index into chosenIndex
        let chosenIndex:Int = cards.firstIndex(matching: card)!
        
        //De-Selection if count is below 3 and card is already selected
        if faceUpCards.count != 3 && cards[chosenIndex].isSelected == true {
                cards[chosenIndex].isSelected = false
                faceUpCards.remove(at: (faceUpCards.firstIndex(matching: card))!)
            
        //Selection
        } else {
            cards[chosenIndex].isSelected = true
            faceUpCards.append(card)
        }
    

        //Check for a Match if 3 Cards were Previously Chosen (and 4 is currently showing)
        if faceUpCards.count == 4 {
            
            if faceUpCards[0].number == faceUpCards[1].number && faceUpCards[1].number == faceUpCards[2].number && faceUpCards[0].number == faceUpCards[2].number ||
                faceUpCards[0].number != faceUpCards[1].number && faceUpCards[1].number != faceUpCards[2].number && faceUpCards[0].number != faceUpCards[2].number {
                match[0] = true
            }
            if faceUpCards[0].color == faceUpCards[1].color && faceUpCards[1].color == faceUpCards[2].color && faceUpCards[0].color == faceUpCards[2].color ||
                faceUpCards[0].color != faceUpCards[1].color && faceUpCards[1].color != faceUpCards[2].color && faceUpCards[0].color != faceUpCards[2].color {
                match[1] = true
            }
            if faceUpCards[0].shading == faceUpCards[1].shading && faceUpCards[1].shading == faceUpCards[2].shading && faceUpCards[0].shading == faceUpCards[2].shading ||
                faceUpCards[0].shading != faceUpCards[1].shading && faceUpCards[1].shading != faceUpCards[2].shading && faceUpCards[0].shading != faceUpCards[2].shading {
                match[2] = true
            }
            if faceUpCards[0].symbol == faceUpCards[1].symbol && faceUpCards[1].symbol == faceUpCards[2].symbol && faceUpCards[0].symbol == faceUpCards[2].symbol ||
                faceUpCards[0].symbol != faceUpCards[1].symbol && faceUpCards[1].symbol != faceUpCards[2].symbol && faceUpCards[0].symbol != faceUpCards[2].symbol {
                match[3] = true
            }

            
            //Code based on match results
            if match[0] && match[1] && match[2] {
                //IF MATCH
                for i in 0..<3 {
//                    cards[(cards.firstIndex(matching: faceUpCards[i])!)].isOnScreen = false
                    cards[(cards.firstIndex(matching: faceUpCards[i])!)].isMatched = true

                    match[i] = false
                }
                
                for i in 0..<3 {
                    cards.remove(at: cards.firstIndex(matching: faceUpCards[i])!)
                }
                
                for _ in 0..<3 {
                    faceUpCards.remove(at: 0)
                }
                
                addCards()
                
            } else {
                //IF NO MATCH
                for i in 0..<3 {
                    cards[cards.firstIndex(matching: faceUpCards[i])!].isSelected = false
                }
                for _ in 0..<3 {
                    faceUpCards.remove(at: 0)
                }
                

                
                                    
            }
        }
    }
    
    
    
    struct Card: Identifiable {

        var isSelected: Bool = false
        var isOnScreen: Bool = false
        var isMatched: Bool = false
        var id: Int
        
        var number: Int?
        var symbol: CardContent
        var shading: String?
        var color: String?
        
    }
}
