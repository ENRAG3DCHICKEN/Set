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
        
        	
        var body: some View {
            Group {
                Text(String(viewModel.cards.count))
    
                Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture {
                        withAnimation(.linear(duration: 0.75)) {
                            self.viewModel.choose(card: card)
                        }
                    }
                }
                    
                Button(action: {
                    withAnimation(.easeInOut) {
                        self.viewModel.provideMoreCards()
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
            }

        @ViewBuilder
        private func body(for size: CGSize) -> some View {
            Text(self.card.symbol)
                .modifier(Cardify())
            
        }}
    }

            
