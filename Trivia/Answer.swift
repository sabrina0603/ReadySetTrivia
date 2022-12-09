//
//  Answer.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/8/22.
//

import Foundation
import SwiftUI


struct Answer: Identifiable {
    var id = UUID().uuidString
    var text: AttributedString
    var isCorrect: Bool
}

 struct Trivia: Codable, Identifiable {
    let id = UUID().uuidString
    var category: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
    
    enum CodingKeys: CodingKey {
    case category, difficulty, question, correct_answer, incorrect_answers
    }
     var answers: [Answer] {
         do {
            let correct = [Answer(text: try AttributedString(markdown: correct_answer), isCorrect: true)]
             let incorrect = try incorrect_answers.map { answer in
                 Answer(text: try AttributedString(markdown: answer), isCorrect: false)
             }
             let allAnswers = correct + incorrect
             return allAnswers
         } catch {
             print("😡 ERROR: setting answers: \(error.localizedDescription)")
             return []
         }
    }
        
}

