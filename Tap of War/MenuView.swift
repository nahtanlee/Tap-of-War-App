//
//  SwiftUIView.swift
//  Tap of War
//
//  Created by Michael Lee on 6/12/2023.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
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
                            ContentView().gameWon = false
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
    }
}

#Preview {
    SwiftUIView()
}
