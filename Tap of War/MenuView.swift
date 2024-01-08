//
//  MenuView.swift
//  Tap of War
//
//  Created by Michael Lee on 6/12/2023.
//

import SwiftUI

private let CtoS: [Color: String] = [
    .clear : "clear",
    .red : "red",
    .orange : "orange",
    .yellow : "yellow",
    .green : "green",
    .blue : "blue",
    .indigo : "indigo",
    .purple : "purple"
]



struct MenuView: View {
    @State public var menuOffset: CGFloat = -700
    @EnvironmentObject var globalVar: GlobalVar
    
    @State private var fontSize: CGFloat = 85
    var body: some View {
        VStack {
            
            RoundedRectangle(cornerRadius: 40)
                .frame(width: 275, height: 440, alignment: .center)
                .foregroundStyle(Color(uiColor: globalVar.settingsActive ? .clear : globalVar.settingsToMenu ? .clear : .systemGray5))
                .overlay(
                    VStack {
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        
                        
                        //Title text
                        if globalVar.gameWon == "_" {
                            Text("tap")
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 25)
                            
                            Text("of")
                                .font(Font.custom("TudorVictors", size: 45))
                                .foregroundStyle(.secondary)
                            
                            Text("war")
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color1)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 25)
                        }
                        
                        // Color 1 won
                        if globalVar.gameWon == "color1" {
                            Text(CtoS[globalVar.color1]!)
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color1)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 25)
                                .padding(.trailing, 25)
                                .minimumScaleFactor(0.01)
                            
                            Text("wins")
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color1)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 25)
                        }
                        

                        // Color 2 won
                        if globalVar.gameWon == "color2" {
                            Text(CtoS[globalVar.color2]!)
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color2)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 25)
                                .padding(.trailing, 25)
                                .minimumScaleFactor(0.01)
                            
                            Text("wins")
                                .font(Font.custom("TudorVictors", size: 85))
                                .foregroundStyle(globalVar.color2)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .padding(.trailing, 25)
                        }
                        
                        
                        // New Game button
                        Button(action: {
                            globalVar.newGame = true
                            if globalVar.haptic {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                            }
                            withAnimation(.easeInOut(duration: 1)) {
                                globalVar.tint = 1.0
                            }
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.2)) {
                                menuOffset = -100
                                globalVar.ratio = 0.5
                              }
                            
                            // Delay return
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                                    menuOffset = 700
                                    if globalVar.haptic {
                                        UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 1.0)
                                    }
                                }
                              }
                            
                            // Wait for animation to complete
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                withAnimation(.linear) {
                                    globalVar.gameWon = "nil"
                                }
                            }
                            
                        }) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color(uiColor: .systemGray4))
                                .frame(width: 200, height: 50)
                                .overlay(
                                    HStack {
                                        Image(systemName: "play.fill")
                                            .foregroundStyle(.primary)
                                            .imageScale(.large)
                                        Text("New Game")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.primary)
                                            .cornerRadius(10)
                                    }
                                )
                        }
                        
                        .padding(5)
                        
                        
                        
                        
                        
                        //Settings button
                        Button(action: {
                            globalVar.settingsActive = true
                            if globalVar.haptic {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                            }
                            withAnimation(.spring(response: 0.4, dampingFraction: 1, blendDuration: 0.9)) {
                                globalVar.menuHeight = 300
                            }
                        }) {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundStyle(Color(uiColor: .systemGray4))
                                .frame(width: 200, height: 50)
                                .overlay(
                                    HStack {
                                        Image(systemName: "gearshape.fill")
                                            .foregroundStyle(.primary)
                                            .imageScale(.large)
                                        Text("Settings")
                                            .font(.headline)
                                            .fontWeight(.bold)
                                            .foregroundStyle(.primary)
                                            .cornerRadius(10)
                                    }
                                )
                        }
                        
                        
                    }
                    .padding(.bottom, 30)
                )
        }
        .ignoresSafeArea(.all)
        .onAppear {
            if !globalVar.settingsToMenu {
                withAnimation(.easeInOut(duration: 1)) {
                    globalVar.tint = 0.7
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if globalVar.haptic {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                    }
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 1)) {
                        menuOffset = 100
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.2)) {
                        if globalVar.haptic {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred(intensity: 1.0)
                        }
                        menuOffset = 0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
                    withAnimation(.linear) {
                        globalVar.newGame = false
                    }
                }
            } else {
                
                withAnimation(.linear(duration: 0)) {
                    menuOffset = 0
                }

                withAnimation(.linear(duration: 0.5)) {
                    globalVar.menuOpacity = 1
                    globalVar.settingsOpacity = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    withAnimation(.linear(duration: 0)) {
                        globalVar.settingsToMenu = false
                    }
                }
                
            }
        }
        
        .offset(y: menuOffset)
    }
}



#Preview {
    MenuView()
}
