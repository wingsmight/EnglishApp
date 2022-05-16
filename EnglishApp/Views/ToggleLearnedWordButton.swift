//
//  ToggleLearnedWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI


struct ToggleLearnedWordButton: View {
    @Binding public var wordPair: WordPair?

    @State private var isEnabled: Bool
    
    
    
    init(wordPair: Binding<WordPair?>) {
        self._wordPair = wordPair
        
        if let wordPair = wordPair.wrappedValue {
            self.isEnabled = wordPair.state == .learned
        } else {
            self.isEnabled = false
        }
    }
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Checkmark"), enabledColor: Color("AppGreen"))
            .onChanged(of: isEnabled, perform: { newValue in
                if wordPair != nil {
                    if newValue {
                        self.wordPair!.state = .learned
                    } else {
                        self.wordPair!.state = .none
                    }
                }
            })
            .disabled(wordPair == nil)
    }
}
