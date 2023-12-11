//
//  ContentView.swift
//  Tap of War
//
//  Created by Nathan Lee on 5/12/2023.
//

import SwiftUI

struct GameView: View {
    let topBarHeight: CGFloat = 44
    public var difficulty = 0.01
    @State public var gameWon = false
    @State public var ratio = 0.5
    @State private var topShapeTapped = false
    @State private var bottomShapeTapped = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                let cornerRadius: CGFloat = 15
        
                // Top bar
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: topBarHeight)
                    .foregroundColor(Color.black)
                
                // First Shape (top half)
                Button(action: {
                    ratio = ratio + difficulty
                }) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 40, bottomLeading: cornerRadius, bottomTrailing: cornerRadius, topTrailing: 40))
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * ratio + 40 - topBarHeight)
                        .foregroundColor(Color.blue)
                }
                
                Spacer()
                
                // Second Shape (bottom half)
                Button(action: {
                    ratio = ratio - difficulty
                }) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: cornerRadius, bottomLeading: 40, bottomTrailing: 40, topTrailing: cornerRadius))
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * (1 - ratio) + 40 - topBarHeight)
                        .foregroundColor(Color.red)
                }
                
                // Bottom bar
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: topBarHeight)
                    .foregroundColor(Color.black)
            }
            .ignoresSafeArea(.all)
            
            // -------------------------- //
            // Start Menu
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color.white)
                    .overlay(
                        VStack {
                            Text("Tap of War")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding()
                            Button(action: {
                                // Add logic to start the game here
                                // You might want to update the game state or navigate to another view
                            }) {
                                Text("Start Game")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                        }
                    )
                    .padding()
            }
            .opacity(gameWon ? 0 : 1) // Optionally hide the overlay when the game is won
            
        }
    }
}

#Preview {
    ContentView()
}
