//
//  WordCard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI


struct WordCard: View {
    @Binding public var wordPair: WordPair
    
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
            }
            
            VStack {
                OriginalWordBlock(wordPair: $wordPair)
                    .padding(.top, 100)
                WordInfoView(word: $wordPair.Translation, wordLanguage: .constant(.english), wordPair: $wordPair)
                Spacer()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    struct OriginalWordBlock: View {
        @Binding public var wordPair: WordPair
        
        
        var body: some View {
            HStack {
                Text(wordPair.Original)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                WordControlPanel(wordPair: Binding<WordPair?>($wordPair), wordToSpeak: $wordPair.Original)
                    .padding()
            }
        }
    }
    
    struct Header: View { 
        var body: some View {
            HStack {
                Spacer()
                
                CloseNavigationButton()
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct WordCard_Previews: PreviewProvider {
    private static let wordPair = WordPair("Bag", "Сумка")
    static var previews: some View {
        WordCard(wordPair: .constant(wordPair))
    }
}
