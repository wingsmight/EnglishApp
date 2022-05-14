//
//  ToggleLearnedWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearnedWordButton: View {
    var wordPair: WordPair?
    
    
    @State private var isEnabled: Bool
    
    
    init(wordPair: WordPair?) {
        self.wordPair = wordPair
        
        if let wordPair = wordPair {
            self.isEnabled = Shared.instance.learnedWordPairs.contains(wordPair)
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Checkmark"), enabledColor: Color("AppGreen"))
            .onChanged(of: isEnabled, perform: { newValue in
                if let wordPair = wordPair {
                    if newValue {
                        Shared.instance.learnedWordPairs.appendIfNotContains(wordPair)
                    } else {
                        Shared.instance.learnedWordPairs.removeAll(where: { $0 == wordPair })
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}

struct ToggleLearnedWordButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleLearnedWordButton(wordPair: WordPair(original: "Word", translation: "Слово"))
    }
}
