//
//  NewWordButtonView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI

struct NewWordButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        Button("Neues Wort", action: action)
            .font(.title2)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    NewWordButtonView(action: {})
}
