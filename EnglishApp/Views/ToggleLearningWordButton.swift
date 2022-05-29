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
                self.wordPair!.state = .learning
                self.wordPair!.isPushed = true
            } else {
                self.wordPair!.state = .none
            }
        })
            .onChanged(of: wordPair?.state, perform: { newState in
                isEnabled = newState == .learning
            })
            .onAppear() {
                if let wordPair = wordPair {
                    isEnabled = wordPair.state == .learning
                }
            }
            .disabled(wordPair == nil)
    }
}
