//
//  ToggleLearningWordButton.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct ToggleLearningWordButton: View {
    @Binding public var wordPair: WordPair?

    @State private var isEnabled: Bool = false
    
    
    var body: some View {
        ToggleCircleImage(isEnabled: $isEnabled, image: Image("Bell"), enabledColor: Color("AppYellow"), onTap: { newValue in
            if newValue {
                self.wordPair!.State = .learning
                self.wordPair!.IsPushed = true
            } else {
                self.wordPair!.State = .none
            }
        })
            .onChanged(of: wordPair?.State, perform: { newState in
                isEnabled = newState == .learning
            })
            .onAppear() {
                if let wordPair = wordPair {
                    isEnabled = wordPair.State == .learning
                }
            }
            .disabled(wordPair == nil)
    }
}
