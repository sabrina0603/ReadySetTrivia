//
//  AnswerView.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/8/22.
//

import SwiftUI

struct AnswerView: View {
    @State private var isSelected = false
    var answer: Answer
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        HStack {
            if isSelected {
                Image(systemName: answer.isCorrect ? "checkmark" : "xmark")
                    .fontWeight(.black)
                if !answer.isCorrect {
                    Text("Correct Answer: \(gameManager.correctAnswer)")
                        .multilineTextAlignment(.center)
                    Image(systemName: answer.isCorrect ? "checkmark" : "xmark")
                        .fontWeight(.black)
                }
               
            }else {
                Text(answer.text)
                    
            }
        }
        .fontWeight(.medium)
        .font(.title2)
        .padding()
        .frame(maxWidth: .infinity, alignment: (isSelected ? .center : .leading))
        .foregroundColor(isSelected ? .white : (Color("darkBlue")))
        .background(gameManager.answerSelected ? (isSelected ? (answer.isCorrect ? .green : .red) : Color("yellowy")) : Color("yellowy"))
        .cornerRadius(8)
        .onTapGesture {
            if !gameManager.answerSelected {
                isSelected = true
                gameManager.selectAnswer(answer: answer)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                gameManager.nextQ()
            }
        }
    }
    
}


struct AnswerView_Previews: PreviewProvider {
    static var previews: some View {
        AnswerView(answer: Answer(text: "shihgds", isCorrect: false))
            .environmentObject(GameManager())
    }
}
