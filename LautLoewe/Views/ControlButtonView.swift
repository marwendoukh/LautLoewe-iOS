//
//  ControlButtonView.swift
//  LautLoewe
//
//  Created by Marwen Doukh on 18.01.25.
//

import SwiftUI

struct ControlButtonView: View {
    
    @Binding var isRecording: Bool

    let onRecord: () -> Void
    let onStop: () -> Void
    let onPlay: () -> Void
    
    var body: some View {
        HStack(spacing: 30) {
            Button(action: {
                if self.isRecording {
                    self.isRecording = false
                    self.onStop()
                } else {
                    self.isRecording = true
                    self.onRecord()
                }
            }) {
                Image(systemName: self.isRecording ? "stop.circle.fill" : "mic.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.blue)
            }
            
            Button(action: self.onPlay) {
                Image(systemName: "speaker.wave.2.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.green)
            }
        }
    }
}
