//
//  ToggleLearningWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearningWordButton: View {
    var wordPair: WordPair?
    
    
    @State private var isEnabled: Bool
    
    
    init(wordPair: WordPair?) {
        self.wordPair = wordPair
        
        print(Shared.instance.learningWordPairs)
        
        if let wordPair = wordPair {
            self.isEnabled = Shared.instance.learningWordPairs.contains(wordPair)
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Bell"), enabledColor: Color("AppYellow"))
            .onChanged(of: isEnabled, perform: { newValue in
                if let wordPair = wordPair {
                    if newValue {
                        Shared.instance.learningWordPairs.appendIfNotContains(wordPair)
                        print(Shared.instance.learningWordPairs)
                    } else {
                        Shared.instance.learningWordPairs.removeAll(where: { $0 == wordPair })
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}

struct ToggleLearningWordButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleLearningWordButton(wordPair: WordPair(original: "Word", translation: "Слово"))
    }
}
