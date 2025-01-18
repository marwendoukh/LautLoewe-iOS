//
//  ContentView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationStack {
            PlayScreen(viewModel: PlayScreenViewModel(wordProvider: WordProvider(),
                                                      speechEngine: SpeechEngineProvider()))
        }
    }
}

#Preview {
    ContentView()
}
