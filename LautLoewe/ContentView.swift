//
//  ContentView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            
            NavigationStack {
                LettersScreen()
            }
            .tabItem {
                Label("Buchstaben", systemImage: "translate")
            }
            
            NavigationStack {
                PlayScreen(viewModel: PlayScreenViewModel(wordProvider: WordProvider(),
                                                          speechEngine: SpeechEngineProvider.shared))
            }
            .tabItem {
                Label("Spiel", systemImage: "play.circle.fill")
            }
            
        }
        
    }
}

#Preview {
    ContentView()
}
