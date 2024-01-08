//
//  SettingsView.swift
//  Tap of War
//
//  Created by Michael Lee on 11/12/2023.
//

import SwiftUI

private let colors: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]

private let ItoC: [Int: Color] = [
    1 : .clear,
    2 : .clear,
    3 : .red,
    4 : .orange,
    5 : .yellow,
    6 : .green,
    7 : .blue,
    8 : .indigo,
    9 : .purple,
    10 : .clear,
    11 : .clear
]

private let CtoI: [Color: Int] = [
    .clear : 0,
    .red : 3,
    .orange : 4,
    .yellow : 5,
    .green : 6,
    .blue : 7,
    .indigo : 8,
    .purple : 9
]


struct SettingsView: View {
    @EnvironmentObject var globalVar: GlobalVar
    @State var selected1: Int? = nil
    @State var selected2: Int? = nil
    let gameView = GameView()
    
    var body: some View {
        RoundedRectangle(cornerRadius: 40)
            .frame(width: 275, height: 300, alignment: .leading)
            .foregroundStyle(Color(uiColor: .clear))
            .overlay(
                VStack {
                    // Difficulty slider
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Text("Difficulty")
                            .frame(width: 70, height: 40, alignment: .center)
                            .foregroundStyle(Color(.white))
                        

                            UISliderView(value: $globalVar.difficulty, minValue: 1, maxValue: 10, tintColor: .white)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    
                    // Color 1 picker
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Text("Colour 1")
                            .frame(width: 70, height: 40, alignment: .leading)
                            .foregroundStyle(Color(.white))
                        Rectangle()
                            .frame(width: .infinity, height: 40)
                            .foregroundStyle(.clear)
                            .overlay(
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(alignment: .center, spacing: 8) {
                                        ForEach(colors, id: \.self) { int in
                                            let color = ItoC[int]
                                            Circle()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(color)
                                        }
                                    }
                                    .onAppear() {
                                        selected1 = CtoI[globalVar.color1]! - 2
                                    }
                                    .scrollTargetLayout()
                                    
                                }
                                .scrollPosition(id: $selected1)
                                .onChange(of: selected1) {
                                    withAnimation(.linear(duration: 0.2)) {
                                        globalVar.color1 = ItoC[(selected1 ?? 1) + 2] == .clear ? .purple : ItoC[(selected1 ?? 1) + 2] ?? .clear
                                        if globalVar.haptic {
                                            UISelectionFeedbackGenerator().selectionChanged()
                                        }
                                    }
                                }
                                .scrollTargetBehavior(.viewAligned)

                            )
                        
                            // Fade edges from black
                            .mask(
                                HStack(spacing: 0) {

                                    // Left gradient
                                    LinearGradient(gradient:
                                       Gradient(
                                           colors: [Color.black.opacity(0), Color.black]),
                                           startPoint: .leading, endPoint: .trailing
                                       )
                                       .frame(width: 50)

                                    // Middle
                                    Rectangle().fill(Color.black)

                                    // Right gradient
                                    LinearGradient(gradient:
                                       Gradient(
                                           colors: [Color.black, Color.black.opacity(0)]),
                                           startPoint: .leading, endPoint: .trailing
                                       )
                                       .frame(width: 50)
                                }
                             )
                        
                            .overlay(
                                Circle()
                                    .stroke(globalVar.color1, lineWidth: 2.5)
                                    .frame(width: 32.5, height: 32.5, alignment: .center)
                            )
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    
                    // Color 2 picker
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Text("Colour 2")
                            .frame(width: 70, height: 40, alignment: .leading)
                            .foregroundStyle(Color(.white))
                        Rectangle()
                            .frame(width: .infinity, height: 40)
                            .foregroundStyle(.clear)
                            .overlay(
                                ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(alignment: .center, spacing: 8) {
                                        ForEach(colors, id: \.self) { int in
                                            let color = ItoC[int]
                                            Circle()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(color)
                                        }
                                    }
                                    .onAppear() {
                                        selected2 = CtoI[globalVar.color2]! - 2
                                    }
                                    .scrollTargetLayout()
                                    
                                }
                                .scrollPosition(id: $selected2)
                                .onChange(of: selected2) {
                                    withAnimation(.linear(duration: 0.2)) {
                                        globalVar.color2 = ItoC[(selected2 ?? 1) + 2] == .clear ? .purple : ItoC[(selected2 ?? 1) + 2] ?? .clear
                                        if globalVar.haptic {
                                            UISelectionFeedbackGenerator().selectionChanged()
                                        }
                                    }
                                }
                                .scrollTargetBehavior(.viewAligned)

                            )
                        
                            // Fade edges from black
                            .mask(
                                HStack(spacing: 0) {

                                    // Left gradient
                                    LinearGradient(gradient:
                                       Gradient(
                                           colors: [Color.black.opacity(0), Color.black]),
                                           startPoint: .leading, endPoint: .trailing
                                       )
                                       .frame(width: 50)

                                    // Middle
                                    Rectangle().fill(Color.black)

                                    // Right gradient
                                    LinearGradient(gradient:
                                       Gradient(
                                           colors: [Color.black, Color.black.opacity(0)]),
                                           startPoint: .leading, endPoint: .trailing
                                       )
                                       .frame(width: 50)
                                }
                             )
                        
                            .overlay(
                                Circle()
                                    .stroke(globalVar.color2, lineWidth: 2.5)
                                    .frame(width: 32.5, height: 32.5, alignment: .center)
                            )
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    // Haptic feedback toggle
                    HStack {
                        Spacer()
                        Spacer()
                        
                        Text("Haptics")
                            .frame(width: 70, height: 40, alignment: .leading)
                            .foregroundStyle(Color(.white))
                        
                        Toggle(isOn: $globalVar.haptic) {
                            EmptyView()
                        }
                        .toggleStyle(CheckmarkToggleStyle())
                        
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    
                    
                    Text("© Tap of War - Nathan Lee")
                        .font(.system(size: 10, weight: .light))
                        .italic(true)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 2)

                    
                    // Back button
                    Button(action: {
                        globalVar.settingsActive = false
                        globalVar.settingsToMenu = true
                        if globalVar.haptic {
                            UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                        }
                        
                        withAnimation(.spring(response: 0.4, dampingFraction: 1, blendDuration: 0.9)) {
                            globalVar.menuHeight = 440
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            globalVar.settingsToMenu = false
                          }
                    }) {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundStyle(.ultraThinMaterial)
                            .frame(width: 200, height: 50)
                            .overlay(
                                HStack {
                                    Image(systemName: "chevron.backward")
                                        .foregroundStyle(.primary)
                                        .imageScale(.large)
                                        .bold(true)
                                    Text("Back")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.primary)
                                        .cornerRadius(10)
                                }
                            )
                    }
                    
                    
                    
                    
                }
                .onAppear {
                    withAnimation(.linear(duration: 0.5)) {
                        globalVar.settingsOpacity = 1
                        globalVar.menuOpacity = 0
                    }
                }
                
            )
    }
}

#Preview {
    SettingsView()
}



// UIKit slider
struct UISliderView: UIViewRepresentable {
    @Binding var value: Double
    @EnvironmentObject var globalVar: GlobalVar
    
    var minValue = 1.0
    var maxValue = 100.0
    var thumbColor: UIColor = .white
    var tintColor: UIColor = .white
    
    class Coordinator: NSObject {
        var value: Binding<Double>
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
        }
    }
    
    func makeCoordinator() -> UISliderView.Coordinator {
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)

        
        slider.thumbTintColor = thumbColor
        slider.minimumTrackTintColor = UIColor(globalVar.color1)
        slider.maximumTrackTintColor = UIColor(globalVar.color2)
        slider.minimumValue = Float(minValue)
        slider.maximumValue = Float(maxValue)
        
        
        slider.value = Float(value)
        slider.tintColor = tintColor
        slider.setThumbImage(UIImage(systemName: "capsule.portrait.fill"), for: .normal)
        slider.setThumbImage(UIImage(systemName: "capsule.portrait.fill"), for: .highlighted)
        
        
        slider.addTarget(
            context.coordinator,
            action: #selector(Coordinator.valueChanged(_:)),
            for: .valueChanged
        )
        
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(value)
    }
}


// Custom haptic toggle
struct CheckmarkToggleStyle: ToggleStyle {
    @EnvironmentObject var globalVar: GlobalVar
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Rectangle()
                .foregroundColor(configuration.isOn ? globalVar.color1 : globalVar.color2)
                .frame(width: 44, height: 28, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "checkmark" : "xmark")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? globalVar.color1 : globalVar.color2)
                        )
                        .offset(x: configuration.isOn ? 9 : -9, y: 0)
                        .animation(Animation.linear(duration: 0.2), value: globalVar.haptic)
                    
                )
                .cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle()
                    if globalVar.haptic {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred(intensity: 1.0)
                    }
                }
        }
    }
}
