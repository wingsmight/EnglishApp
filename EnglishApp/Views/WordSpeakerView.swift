//
//  WordSpeaker.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI
import AVFoundation

struct WordSpeakerView: View {
    @Binding var word: String
    
    
    var body: some View {
        Button {
            speak(word: word)
        } label: {
            Image("Speaker")
                .resizable()
                .frame(width: 22, height: 22)
        }
        .buttonStyle(.plain)
    }
    
    
    func speak(word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: LanguageDetection.detectLanguageCode(for: word))

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
}

struct WordSpeaker_Previews: PreviewProvider {
    static var previews: some View {
        WordSpeakerView(word: .constant("Word"))
    }
}
