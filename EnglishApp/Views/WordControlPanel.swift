//
//  WordControlPanel.swift
//  EnglishApp
//
//  Created by Igoryok on 14.05.2022.
//

import SwiftUI

struct WordControlPanel: View {
    @Binding var word: String
    
    
    var body: some View {
        VStack {
            WordSpeakerView(word: $word)
            
            ToggleCircleImage(image: Image("Checkmark"), enabledColor: Color("AppGreen"), action: { _ in
                // Action
            })
            
            ToggleCircleImage(image: Image("Bell"), enabledColor: Color("AppYellow"), action: { _ in
                // Action
            })
        }
    }
}

struct WordControlPanel_Previews: PreviewProvider {
    static var previews: some View {
        WordControlPanel(word: .constant("Word"))
    }
}
