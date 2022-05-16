//
//  ToggleLearningWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearningWordButton: View {
    @Binding public var wordPair: WordPair?

    @State private var isEnabled: Bool
    
    
    
    init(wordPair: Binding<WordPair?>) {
        self._wordPair = wordPair
        
        if let wordPair = wordPair.wrappedValue {
            self.isEnabled = wordPair.state == .learning
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Bell"), enabledColor: Color("AppYellow"))
            .onChanged(of: isEnabled, perform: { newValue in
                if wordPair != nil {
                    if newValue {
                        self.wordPair!.state = .learning
                    } else {
                        self.wordPair!.state = .none
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}
