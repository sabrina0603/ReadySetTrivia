//
//  EndView.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/8/22.
//

import SwiftUI

struct EndView: View {
    @EnvironmentObject var gameManager: GameManager
    //@Environment(\.dismiss) private var dismiss
    var body: some View {
        if gameManager.end == true {
            VStack(spacing: 20) {
                Image(gameManager.score > 9 ? "smart" : gameManager.score > 6 ? "great" : "cry")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text(gameManager.score > 9 ? "🥳Congrats🥳" : gameManager.score > 6 ? "👏Great Job👏" : "😬Better luck next time😬")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color("yellowy"))
                Text("Score \(gameManager.score)/\(gameManager.length)")
                    .foregroundColor(Color("yellowy"))
                Text("Highscore:  \(gameManager.highScore)/\(gameManager.length)")
                    .foregroundColor(Color("yellowy"))
                
                Button {
                    Task.init {
                        await gameManager.getQuestion()
                    }
                } label: {
                    Text("Play again")
                }
                
                .foregroundColor(.black)
                .padding()
                .padding(.horizontal)
                .background(Color("yellowy"))
                .cornerRadius(30)
                .font(.title2)
                .bold()
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color("darkBlue"))
            .navigationBarBackButtonHidden()
            .statusBarHidden()
        } else {
            QuestionView(progress: 10)
        }
    }
}

struct EndView_Previews: PreviewProvider {
    static var previews: some View {
        EndView()
            .environmentObject(GameManager())
    }
}
