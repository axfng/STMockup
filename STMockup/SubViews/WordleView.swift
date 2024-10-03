//
//  WordleView.swift
//  STMockup
//
//  Created by alfeng on 9/29/24.
//

import SwiftUI

struct WordleView: View {
    let words = ["ATOMS", "BRAIN", "CELLS", "LASER", "NERVE", "VIRUS", "HELIX"]
        
    @State private var currentWord: String = ""
    @State private var guessedWords: [String] = Array(repeating: "", count: 6)
    @State private var currentGuess: String = ""
    @State private var attemptIndex: Int = 0
    @State private var gameWon: Bool = false
    @State private var gameOver: Bool = false
        
    var body: some View {
            VStack(spacing: 20) {
                Text("Science Wordle")
                    .font(.largeTitle.bold())
                
                Text("Guess the 5-letter science word!")
                    .font(.subheadline)
                
                ForEach(0..<6, id: \.self) { index in
                    WordRowView(word: guessedWords[index], correctWord: currentWord)
                        .padding(5)
                }
                
                if gameWon {
                    Text("Congratulations! You guessed the word! 🎉")
                        .font(.title2)
                        .foregroundColor(.green)
                } else if gameOver {
                    Text("Game Over! The word was \(currentWord)")
                        .font(.title2)
                        .foregroundColor(.red)
                } else {
                    HStack {
                        TextField("Enter guess", text: $currentGuess)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 150)
                            .onChange(of: currentGuess) { newValue in
                                if newValue.count > 5 {
                                    currentGuess = String(newValue.prefix(5))
                                }
                            }
                        
                        Button(action: makeGuess) {
                            Text("Guess")
                                .padding(7)
                                .background(Color.mint)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .disabled(currentGuess.count != 5)
                    }
                    .padding()
                }
                
                Button(action: resetGame) {
                    Text("New Game")
                        .padding(10)
                        .background(Color.mint)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onAppear {
                startNewGame()
            }
        }
        
        private func startNewGame() {
            currentWord = words.randomElement() ?? "PLANT"
            guessedWords = Array(repeating: "", count: 6)
            currentGuess = ""
            attemptIndex = 0
            gameWon = false
            gameOver = false
        }
        
        private func makeGuess() {
            if attemptIndex < 6 {
                guessedWords[attemptIndex] = currentGuess.uppercased()
                if currentGuess.uppercased() == currentWord {
                    gameWon = true
                } else {
                    attemptIndex += 1
                    if attemptIndex >= 6 {
                        gameOver = true
                    }
                }
                currentGuess = ""
            }
        }
        
        private func resetGame() {
            startNewGame()
        }
}

struct WordRowView: View {
    var word: String
    var correctWord: String
    @State private var lightGray = Color(red: 211/255, green: 211/255, blue: 211/255)
    
    var body: some View {
        HStack {
            ForEach(0..<5, id: \.self) { index in
                let letter = index < word.count ? String(word[word.index(word.startIndex, offsetBy: index)]) : " "
                Text(letter)
                    .frame(width: 40, height: 40)
                    .background(colorForLetter(at: index))
                    .foregroundColor(.white)
                    .border(lightGray)
                    .cornerRadius(5)
            }
        }
    }
    
    private func colorForLetter(at index: Int) -> Color {
        guard index < word.count else { return lightGray }
        
        let guessedLetter = word[word.index(word.startIndex, offsetBy: index)]
        let correctLetter = correctWord[correctWord.index(correctWord.startIndex, offsetBy: index)]
        
        if guessedLetter == correctLetter {
            return .green // Correct position
        } else if correctWord.contains(guessedLetter) {
            return .yellow // Correct letter, wrong position
        } else {
            return lightGray // Incorrect letter
        }
    }
}

#Preview {
    WordleView()
}
