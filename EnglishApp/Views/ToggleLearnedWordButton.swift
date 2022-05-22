//
//  ToggleLearnedWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearnedWordButton: View {
    @Binding public var wordPair: WordPair?
    
    @State private var isEnabled: Bool = false
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Checkmark"), enabledColor: Color("AppGreen"), onTap: { newValue in
            if newValue {
                self.wordPair!.state = .learned
            } else {
                self.wordPair!.state = .none
            }
        })
            .onChanged(of: wordPair?.state, perform: { newState in
                isEnabled = newState == .learned
            })
            .onAppear() {
                if let wordPair = wordPair {
                    isEnabled = wordPair.state == .learned
                }
            }
            .disabled(wordPair == nil)
    }
}
