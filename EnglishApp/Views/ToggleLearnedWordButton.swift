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
                self.wordPair!.State = .learned
            } else {
                self.wordPair!.State = .none
            }
            self.wordPair!.IsPushed = false
        })
            .onChanged(of: wordPair?.State, perform: { newState in
                isEnabled = newState == .learned
            })
            .onAppear() {
                if let wordPair = wordPair {
                    isEnabled = wordPair.State == .learned
                }
            }
            .disabled(wordPair == nil)
    }
}
