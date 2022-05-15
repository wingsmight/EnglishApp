//
//  WordControlPanel.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct WordControlPanel: View {
    public let wordPair: WordPair?
    @Binding public var learnedWordPairs: [WordPair]
    @Binding public var learningWordPairs: [WordPair]
    
    
    var body: some View {
        VStack {
            WordSpeakerView(word: .constant(wordPair?.Original ?? ""))
            
            ToggleLearnedWordButton(wordPair: wordPair, learnedWordPairs: $learnedWordPairs)
            
            ToggleLearningWordButton(wordPair: wordPair, learningWordPairs: $learningWordPairs)
        }
    }
}

//struct WordControlPanel_Previews: PreviewProvider {
//    static var previews: some View {
//        WordControlPanel(wordPair: .constant(WordPair("Word", "Слово")))
//    }
//}
