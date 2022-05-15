//
//  ToggleLearnedWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearnedWordButton: View {
    public let wordPair: WordPair?
    @Binding public var learnedWordPairs: [WordPair]

    @State private var isEnabled: Bool
    
    
    
    init(wordPair: WordPair?, learnedWordPairs: Binding<[WordPair]>) {
        self.wordPair = wordPair
        self._learnedWordPairs = learnedWordPairs
        
        if let wordPair = wordPair {
            self.isEnabled = learnedWordPairs.wrappedValue.contains(wordPair)
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Checkmark"), enabledColor: Color("AppGreen"))
            .onChanged(of: isEnabled, perform: { newValue in
                if let wordPair = wordPair {
                    if newValue {
                        learnedWordPairs.appendIfNotContains(wordPair)
                    } else {
                        learnedWordPairs.removeAll(where: { $0 == wordPair })
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}
