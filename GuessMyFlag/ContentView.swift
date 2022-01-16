//
//  ContentView.swift
//  GuessMyFlag
//
//  Created by Santhosh Srinivas on 09/12/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var finalTitle = ""
    @State private var restartGame = false
    @State private var scoreTitle = ""
    @State private var totalScore = 0
    @State private var totalQues = 1
    @State private var ans = 0
    @State private var finalScore = 0
    
    @State private var countries = ["Estonia", "France","Germany","Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAns = Int.random(in: 0...2)
    
    var body: some View{
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.3, green: 0.56, blue: 0.15, opacity: 0.96), location: 0.2),
                .init(color: Color(red: 0.8471, green: 0.6078, blue: 0, opacity: 0.85), location: 0.2)
            ],center: .top, startRadius: 200, endRadius: 800)
            // LinearGradient(gradient: Gradient(colors: [.green,.black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()

                Text("GUESS THE FLAG")
                    .foregroundColor(.white)
                    .font(.largeTitle.bold())
                Text("\(totalQues)/8")
                    .foregroundColor(.white)
                    .font(.headline.bold())
                // Spacer()
                // Spacer()
                VStack(spacing: 10){
                VStack{
                    Text("Tap on the flag of")
                        .foregroundStyle(.secondary)
                        .font(.headline.weight(.heavy))
                    Text(countries[correctAns])
                        .font(.title.weight(.heavy))
                }
                ForEach(0..<3){ number in
                    Button{
                        tapFlag(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(color: Color(red: 0.3, green: 0.56, blue: 0.15), radius: 25  , x: 5, y: 2)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(35)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                
                Spacer()
                Spacer()
                
                Text("TOTAL SCORE: \(totalScore)")
                    .foregroundColor(Color(red: 0.3, green: 0.56, blue: 0.15, opacity: 0.96))
                    .font(.title.bold())
                Spacer()
            }
            .padding(35)
        }
//        .alert(finalTitle, isPresented: $restartGame){
//            Button("RESTART??", action: restart)
//        } message: {
//            Text("Your Final score is \(finalScore)")
//        }
        .alert(isPresented: $restartGame){
            Alert(title: Text("Game Over"), message: Text("You have finished the game. Your total score is \(finalScore). Do you wish to continue??"), dismissButton: .default(Text("Restart!")))
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue?", action: reshuffle)
            } message: {
                if scoreTitle == "Correct!!"{
                    Text("That is correct!")
                    Text("Your score is \(totalScore)")
                        .bold()
                } else{
                    Text("That is wrong, You've clicked the \(countries[ans]) flag")
                }
            }
        }
    func tapFlag(_ number: Int){
        if number == correctAns{
            scoreTitle = "Correct!!"
            totalScore += 1
        } else{
            scoreTitle = "Wrong"
            ans = number
        }
        showingScore = true
    }
    
    func restart(){
        if totalQues == 9{
            finalScore = totalScore
            totalScore = 0
            totalQues = 1
            countries.shuffle()
            correctAns = Int.random(in: 0...2)
        }
        finalTitle = "True"
        restartGame = true
    }
    func reshuffle(){
        countries.shuffle()
        correctAns = Int.random(in: 0...2)
        totalQues += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
