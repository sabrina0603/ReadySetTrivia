//
//  TriviaApp.swift
//  Trivia
//
//  Created by Sabrina Cheng on 12/7/22.
//

import SwiftUI


@main
struct TriviaApp: App {
    @StateObject var gameManager = GameManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GameManager())
        }
    }
}
