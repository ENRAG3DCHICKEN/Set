//
//  Cardify.swift
//  NewSetCardGame
//
//  Created by ENRAG3DCHICKEN on 2020-08-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    
    init() {
        rotation = 0
    }
    
    var isFaceUp: Bool {
        rotation < 90
    }
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
                content
            }

                RoundedRectangle(cornerRadius: cornerRadius).fill()

        }
        
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify())
    }
}
