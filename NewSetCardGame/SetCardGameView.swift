//
//  ContentView.swift
//  NewSetCardGame
//
//  Created by ENRAG3DCHICKEN on 2020-08-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct SetCardGameView: View {
        // Portal into the viewModel
        @ObservedObject var viewModel: SetCardGame
    
        @State var cardsOffScreen: Bool = false
    
        var body: some View {
            Group {
                Text(String(viewModel.cards.count))
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.newGame()
                    }
                }, label: { Text("New Game") })

                withAnimation {
                    Grid(viewModel.cards) { card in
                        CardView(card: card).onTapGesture {
                            withAnimation(.linear(duration: 0.75)) {
                                self.viewModel.choose(card: card)
                            }
                        }
                            
                    }
                }
                .transition(AnyTransition.offset(self.cardsOffScreen ? CGSize(width: 0, height: 0) : CGSize(width: Int.random(in:5000..<10000) * Int.random(in:-1...1), height: Int.random(in:5000..<10000) * Int.random(in:-1...1))))


//
//

                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.provideMoreCards()
                        return self.cardsOffScreen = true
                    }
                }, label: { Text("Deal 3 More Cards") })
            }
            


        }

        struct CardView: View {
            var card: SetGame<String>.Card
            
            var body: some View {
                GeometryReader { geometry in
                    self.body(for: geometry.size)
                }
                    .padding(5)
                        .background(card.isSelected ? Color.yellow : Color.white)
            }


        @ViewBuilder
        private func body(for size: CGSize) -> some View {
            
            VStack(alignment: .center) {
                ForEach(1..<card.number!+1) {_ in
                    Text(self.card.symbol)
                }
                    .foregroundColor(card.color == "Red" ? .red : card.color == "Green" ? .green : .purple)
                    .border(card.shading == "Outlined" && card.color == "Red" ? Color.red : card.shading == "Outlined" && card.color == "Green" ? Color.green : card.shading == "Outlined" && card.color == "Purple" ? Color.purple : Color.white)
                    .opacity(card.shading == "Striped" ? 0.5 : 1)
            }


                .font(.system(size: size.height > size.width ? size.width * 0.4: size.height * 0.4))
                .modifier(Cardify())


            
        }}
    }

            
