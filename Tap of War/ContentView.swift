//
//  ContentView.swift
//  Tap of War
//
//  Created by Michael Lee on 6/12/2023.
//

import SwiftUI
import ConfettiSwiftUI

class GlobalVar: ObservableObject {
    @Published var newGame: Bool = false
    @Published var gameWon: String = "_"
    @Published var ratio: Double = 0.5

    @Published var color1: Color = .blue
    @Published var color2: Color = .red
    @Published var haptic: Bool = true
    
    @Published var gameBoardTouch: Bool = false
    @Published var tint: Double = 0.7
    @Published var confetti: Int = 0
    @Published var settingsActive = false
    @Published var menuHeight: CGFloat = 440
    @Published var menuOpacity: Double = 0
    @Published var settingsToMenu: Bool = false
    @Published var settingsOpacity: Double = 0
    
    @Published var difficulty: Double = 3
}

struct ContentView: View {
    @State var splash: Bool = true
    @StateObject var globalVar = GlobalVar()
    
    @State private var confettiColor: Color = .clear
    
    var body: some View {
        ZStack {
            
            GameView()
                .environmentObject(globalVar)
                .statusBar(hidden: globalVar.newGame)
                .disabled(!globalVar.gameBoardTouch)
                .preferredColorScheme(.dark)
                .opacity(globalVar.tint)
                .animation(.easeInOut(duration: 2), value: globalVar.gameWon)

            if globalVar.gameWon != "nil" {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 40)
                        .frame(width: 275, height: globalVar.menuHeight, alignment: .center)
                        .foregroundStyle(Color(uiColor: globalVar.settingsActive ? .systemGray5 : globalVar.settingsToMenu ? .systemGray5 : .clear))
                    
                    if globalVar.settingsActive {
                        SettingsView()
                            .environmentObject(globalVar)
                            .preferredColorScheme(.dark)
                            .opacity(globalVar.settingsOpacity)
                    } else {
                        MenuView()
                            .environmentObject(globalVar)
                            .preferredColorScheme(.dark)
                            .opacity(globalVar.settingsToMenu ? globalVar.menuOpacity : 1)
                    }
                }
                
            }
            
            // Confetti
            VStack {
                if globalVar.gameWon.contains("color") {
                    ConfettiCannon(counter: $globalVar.confetti, colors: [globalVar.gameWon == "color1" ? globalVar.color1 : globalVar.gameWon == "color2" ? globalVar.color2 : .clear], rainHeight: 1200, fadesOut: false, radius: 500, repetitions: 15, repetitionInterval: 0.5)
                        .padding(.bottom, 550)
                }

            }
        }
    }
}


#Preview {
    ContentView()
}
