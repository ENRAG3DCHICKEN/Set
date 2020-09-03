//
//  SetCardGameViewModel.swift
//  NewSetCardGame
//
//  Created by ENRAG3DCHICKEN on 2020-08-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

class Theme {
    static var colors: [String] = ["Red", "Green", "Purple"]
    static var symbols: [String] = ["▬", "●", "◆"]
    static var shadings: [String] = ["Solid", "Striped", "Outlined"]
    static var numbers: [Int] = [1,2,3]
}

class SetCard {
    var number: Int?
    var symbol: String?
    var shading: String?
    var color: String?
    var id: Int?
    
    init(number: Int, symbol: String, shading: String, color: String, id: Int) {
        self.number = number
        self.symbol = symbol
        self.shading = shading
        self.color = color
        self.id = id
    }
}

func populateSetDeck() -> [SetCard] {
    var populatedDeck: [SetCard] = []
    var id: Int = 0
    
    for number in Theme.numbers {
        for symbol in Theme.symbols {
            for shading in Theme.shadings {
                for color in Theme.colors {
                        populatedDeck.append(SetCard(number: number, symbol: symbol, shading: shading, color: color, id: id))
                        id += 1
                    }}}}
    
    return populatedDeck
}


class SetCardGame: ObservableObject {
    @Published private var model: SetGame<String> = SetCardGame.createSetGame(SetDeck: populateSetDeck())
       
    private static func createSetGame(SetDeck: [SetCard]) -> SetGame<String> {
        return SetGame<String>(SetDeck: SetDeck)
   }
    
    var cards: Array<SetGame<String>.Card> {
        return self.model.cards
    }
    
    
    func provideMoreCards() {
        model.addCards()
    }
    
    func choose(card: SetGame<String>.Card){
        model.choose(card: card)
    }
    
    func newGame() {
        model = SetCardGame.createSetGame(SetDeck: populateSetDeck())
    }
    
}
