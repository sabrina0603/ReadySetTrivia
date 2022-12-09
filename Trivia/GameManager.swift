//
//  GameManager.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/8/22.
//

import Foundation
import SwiftUI
import AVFAudio

@MainActor
class GameManager: ObservableObject, Identifiable {
    private struct Returned: Codable {
        var results: [Trivia]
    }
    var triviaArray: [Trivia] = []
    var length = 0
    var index = 0
    var urlString = "https://opentdb.com/api.php?amount=10"
    @Published var end = false
    @Published var answerSelected = false
    @Published var question: AttributedString = ""
    @Published var answerChoices: [Answer] = []
    @Published var progress: CGFloat = 0.00
    @Published var score = 0
    @Published var highScore = 0
    @Published var correctAnswer: AttributedString = ""
    @Published var isLoading = false
    init() {
        Task.init {
            await getQuestion()
        }
    }
    
    
    func getQuestion() async {
        print("🕸 We are accessing the url \(urlString)")
        isLoading = true
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            isLoading = false
            return
        }
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
            guard let returned = try? JSONDecoder().decode(Returned.self, from: data) else {
                print("😡 JSON ERROR: Could not decode returned JSON data")
                isLoading = false
                return
            }
            self.index = 0
            self.score = 0
            self.progress = 0.00
            self.end = false
            
            self.triviaArray = returned.results
            self.length = self.triviaArray.count
            self.setQuestion()
            isLoading = false
        } catch {
            isLoading = false
            print("😡 ERROR: Could not user URL at \(urlString) to get data and response")
        }
    }
    func nextQ() {
        if index + 1 < length {
            index += 1
            setQuestion()
        } else {
            end = true
            highestScore(score: score)
        }
    }
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(length) * 350)
        if index < length  {
            let currentTriviaQuestion = triviaArray[index]
            var formattingQ: AttributedString {
                do {
                    return try AttributedString(markdown: currentTriviaQuestion.question)
                }catch {
                    print("😡 ERROR: formatting questions: \(error.localizedDescription)")
                    return ""
                }
            }
            question = formattingQ
            answerChoices = currentTriviaQuestion.answers.shuffled()
            correctAnswer = currentTriviaQuestion.answers.first?.text ?? ""
        }
    }
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
    func highestScore(score: Int) {
        if end == true && score > highScore {
            highScore = score
        }
        saveData()
    }
    func saveData() {
        let path = URL.documentsDirectory.appending(component: "highScore")
        let data = try? JSONEncoder().encode(highScore) //try? means if error is thrown, data = nil
        do {
            try data?.write(to: path)
        } catch {
            print("😡 ERROR: Could not save data \(error.localizedDescription)")
        }
    }
    
}
