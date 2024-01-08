//
//  GameView.swift
//  Tap of War
//
//  Created by Nathan Lee on 5/12/2023.
//

import SwiftUI

enum countdownAnimation: CaseIterable {
    case start, middle, end
    
    var scale: Double {
        switch self {
        case .start:  1
        case .middle: 0.5
        case .end: 0.5
        }
    }
        
    var opacity: Double {
        switch self {
        case .start:  0
        case .middle: 1
        case .end: 0
        }
    }
}



struct GameView: View {
    let topBarHeight: CGFloat = 40
    let cornerRadius: CGFloat = 15

    @State private var counter: CGFloat = 0
    @EnvironmentObject var globalVar: GlobalVar
    @State private var topShapeTapped = false
    @State private var bottomShapeTapped = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                // modified from slider value in SettingsView
                @State var difficulty: Double = Double(pow((11 - globalVar.difficulty), 2) / 200)

        
                // Top bar
                Rectangle()
                    .frame(maxWidth: .infinity, maxHeight: topBarHeight)
                    .foregroundColor(Color.clear)
                
                // First Shape (top half)
                Button(action: {
                    globalVar.ratio = globalVar.ratio + difficulty
                    if globalVar.haptic {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: globalVar.ratio)
                    }
                    
                    // Check if game has been won
                    if globalVar.ratio >= 1 || globalVar.ratio <= 0 {
                        globalVar.gameWon = "color1"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            globalVar.confetti += 1
                        }
                        globalVar.newGame = false
                        globalVar.gameBoardTouch = false
                        globalVar.confetti += 1
                        
                    } else {
                        globalVar.gameWon = "nil"
                    }
                    
                }) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: 40, bottomLeading: cornerRadius, bottomTrailing: cornerRadius, topTrailing: 40))
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * globalVar.ratio + 40 - topBarHeight)
                        .animation(.bouncy, value: globalVar.ratio)
                        .foregroundColor(globalVar.color1)
                }
                
                Spacer()
                
                // Second Shape (bottom half)
                Button(action: {
                    globalVar.ratio = globalVar.ratio - difficulty
                    if globalVar.haptic {
                        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: (1 - globalVar.ratio))
                    }
                    
                    // Check if game has been won
                    if globalVar.ratio >= 1 || globalVar.ratio <= 0 {
                        globalVar.gameWon = "color2"
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            globalVar.confetti += 1
                        }
                        globalVar.newGame = false
                        globalVar.gameBoardTouch = false
                    } else {
                        globalVar.gameWon = "nil"
                    }
                    
                }) {
                    UnevenRoundedRectangle(cornerRadii: .init(topLeading: cornerRadius, bottomLeading: 40, bottomTrailing: 40, topTrailing: cornerRadius))
                        .frame(maxWidth: .infinity, maxHeight: geometry.size.height * (1 - globalVar.ratio) + 40 - topBarHeight)
                        .animation(.bouncy, value: globalVar.ratio)
                        .foregroundColor(globalVar.color2)
                }
                
                // Bottom bar
                Rectangle()
                .frame(maxWidth: .infinity, maxHeight: topBarHeight)
                .foregroundColor(Color.clear)
            }
            .ignoresSafeArea(.all)
            .background(.clear)
            
            
            // countdown
            if globalVar.newGame {
                Text("3")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .font(.system(size: 300, weight: .black))
                    .phaseAnimator(countdownAnimation.allCases, trigger: counter) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                    } animation: { phase in
                        switch phase{
                        case .start: .easeInOut.delay(1)
                        case .middle: .easeInOut.delay(1)
                        case .end: .easeInOut
                        }
                    }
                    .onAppear{
                        counter += 1
                        if globalVar.haptic {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.25) {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.55)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.70)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.25) {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 0.85)
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.25) {
                                UIImpactFeedbackGenerator(style: .heavy).impactOccurred(intensity: 1)
                            }
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            globalVar.gameBoardTouch = true
                        }
                    }
                
                Text("2")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .font(.system(size: 300, weight: .black))
                    .phaseAnimator(countdownAnimation.allCases, trigger: counter) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                    } animation: { phase in
                        switch phase{
                        case .start: .easeInOut.delay(2)
                        case .middle: .easeInOut.delay(2)
                        case .end: .easeInOut
                        }
                    }
                
                Text("1")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .font(.system(size: 300, weight: .black))
                    .phaseAnimator(countdownAnimation.allCases, trigger: counter) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                    } animation: { phase in
                        switch phase{
                        case .start: .easeInOut.delay(3)
                        case .middle: .easeInOut.delay(3)
                        case .end: .easeInOut
                        }
                    }
                
                Text("GO")
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .font(.system(size: 230, weight: .black))
                    .phaseAnimator(countdownAnimation.allCases, trigger: counter) { content, phase in
                        content
                            .scaleEffect(phase.scale)
                            .opacity(phase.opacity)
                    } animation: { phase in
                        switch phase{
                        case .start: .easeInOut.delay(4)
                        case .middle: .easeInOut.delay(4)
                        case .end: .easeInOut(duration: 2)
                        }
                    }
            }
            
        }
    }
}

#Preview {
    GameView()
}
