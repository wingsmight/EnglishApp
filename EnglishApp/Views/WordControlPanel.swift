//
//  WordControlPanel.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct WordControlPanel: View {
    @Binding public var wordPair: WordPair?
    @Binding public var wordToSpeak: String
    
    
    var body: some View {
        VStack {
            WordSpeakerView(word: $wordToSpeak)
            
            ToggleLearnedWordButton(wordPair: $wordPair)
            
            ToggleLearningWordButton(wordPair: $wordPair)
        }
    }
}

struct WordControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        WordControlPanel(wordPair: .constant(WordPair("Word", "Слово")), wordToSpeak: .constant("Apple"))
    }
}
