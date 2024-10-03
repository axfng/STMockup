//
//  StartingView.swift
//  STMockup
//
//  Created by alfeng on 9/27/24.
//

import SwiftUI

struct StartingView: View {
    @State private var offsetX: CGFloat = 0 // Offset for the X-axis
    @State private var offsetX1: CGFloat = 0
    @State private var opacity: Double = 0.8
    @State private var originalText = "Translated"
    @State private var displayedText = "Translated"
    @State private var isGlitching = false
    let glitchCharacters = "!@#$%^&*+|;:?/\\"
    
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                VStack{
                    Text("Science")
                        .offset(x: offsetX1) // Apply the offset
                        .animation(.easeInOut(duration: 1), value: offsetX1) // Set the animation
                    Text(displayedText)
                        .offset(x: offsetX1) // Apply the offset
                        .animation(.easeInOut(duration: 1), value: offsetX1) 
                        .onAppear {
                            startGlitching()
                        }
                }
                Image("ST-LOGO")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.yellow)
                    .offset(x: offsetX) // Apply the offset
                    .animation(.easeInOut(duration: 1), value: offsetX) // Set the animation
            }
            .opacity(opacity)
            .onAppear {
                offsetX = -UIScreen.main.bounds.width / 6
                offsetX1 = UIScreen.main.bounds.width / 6 
                withAnimation(.easeIn(duration: 1)){
                    opacity = 1.0
                }
            }
            Spacer()
            
        }
    }
    func startGlitching() {
            isGlitching = true
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { timer in
                if !isGlitching {
                    timer.invalidate()
                    displayedText = originalText
                    return
                }
                
                displayedText = glitchText(originalText)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                isGlitching = false
            }
    }
    func stopGlitching() {
            isGlitching = false
    }
        
    func glitchText(_ text: String) -> String {
        var chars = Array(text)
        
        // Change 2-4 random characters in the string
        for _ in 0..<Int.random(in: 2...4) { 
            let randomIndex = Int.random(in: 0..<chars.count)
            let randomChar = glitchCharacters.randomElement() ?? "?"
            chars[randomIndex] = randomChar
        }
        
        return String(chars)
    }
}

#Preview {
    StartingView()
}
