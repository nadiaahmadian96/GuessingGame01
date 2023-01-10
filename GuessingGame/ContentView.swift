//
//  ContentView.swift
//  GuessingGame
//
//  Created by Nadia Ahmadian on 2023-01-06.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    //we’ll be using correctAnswer to decide which country flag should be tapped.
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())//Shortcut
                    .foregroundColor(.white)
                
            VStack(spacing: 15){
                VStack{
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                        .foregroundStyle(.secondary)
                }
                VStack(spacing: 30) {
                    ForEach(0..<3){number in
                        Button{
                            flagTapped(number)
                        }label:{
                            Image(countries[number])
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                            
                        }
                    }
                }

            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
        }
            .padding()

        }
        
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continute",action: askQuestion)
        }
    }
    func flagTapped(_ number : Int){
        if number == correctAnswer{scoreTitle = "Correct"
            score += 5
        }
        else{
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
        }
        showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
