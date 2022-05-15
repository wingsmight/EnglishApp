//
//  ToggleLearningWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearningWordButton: View {
    public let wordPair: WordPair?
    @Binding public var learningWordPairs: [WordPair]

    @State private var isEnabled: Bool
    
    
    init(wordPair: WordPair?, learningWordPairs: Binding<[WordPair]>) {
        self.wordPair = wordPair
        self._learningWordPairs = learningWordPairs
        
        if let wordPair = wordPair {
            self.isEnabled = learningWordPairs.wrappedValue.contains(wordPair)
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Bell"), enabledColor: Color("AppYellow"))
            .onChanged(of: isEnabled, perform: { newValue in
                if let wordPair = wordPair {
                    if newValue {
                        learningWordPairs.appendIfNotContains(wordPair)
                    } else {
                        learningWordPairs.removeAll(where: { $0 == wordPair })
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}
