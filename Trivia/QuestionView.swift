//
//  QuestionView.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/8/22.
//

import SwiftUI


struct QuestionView: View {
    @EnvironmentObject var gameManager: GameManager
    var progress: CGFloat
    var body: some View {
        ZStack {
            VStack(spacing: 40) {
                Text("\(gameManager.index + 1) out of \(gameManager.length)")
                    .foregroundColor(Color("yellowy"))
                    .fontWeight(.black)
                    .font(.title3)
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(maxWidth: 350,maxHeight: 4)
                        .foregroundColor(.gray)
                        .cornerRadius(10)
                    Rectangle()
                        .frame(width: gameManager.progress, height: 4)
                        .foregroundColor(Color("yellowy"))
                        .cornerRadius(10)
                }
                VStack(alignment: .leading, spacing: 20) {
                    Text(gameManager.question)
                        .font(.system(size: 25, weight: .heavy))
                        .foregroundColor(.white)
                    ForEach(gameManager.answerChoices, id: \.id) {answer in
                        AnswerView(answer: answer)
                    }
                    Spacer()
                }
            }
            if gameManager.isLoading {
                ProgressView()
                    .scaleEffect(4)
                    .tint(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background(Color("darkBlue"))
        .navigationBarBackButtonHidden()
        .statusBarHidden()
    }
    
}

struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionView(progress: 10)
            .environmentObject(GameManager())
    }
}
