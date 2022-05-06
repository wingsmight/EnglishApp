//
//  WordCard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI


struct WordCard: View {
    var wordPair: WordPair
    
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
            }
            
            VStack {
                OriginalWordBlock(word: wordPair.Original)
                    .padding(.top, 100)
                TranslationBlock(word: wordPair.Translation)
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    struct OriginalWordBlock: View {
        var word: String
        
        
        var body: some View {
            HStack {
                Text(word)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                VStack {
                    ToggleCircleImage(image: Image("Speaker"), enabledColor: Color("AppCyan"), action: { _ in
                        // Action
                    })
                    ToggleCircleImage(image: Image("Checkmark"), enabledColor: Color("AppGreen"), action: { _ in
                        // Action
                    })
                    ToggleCircleImage(image: Image("Bell"), enabledColor: Color("AppYellow"), action: { _ in
                        // Action
                    })
                }
                .padding()
            }
        }
    }
    
    struct TranslationBlock: View {
        private static var exampleWordPairs: [[WordPair]] = [
            [WordPair(original: "сумка", translation: "handbag"), WordPair(original: "чехол", translation: "case"), WordPair(original: "сумочка", translation: "case")],
            [WordPair(original: "мешок", translation: "pouch"), WordPair(original: "пакет", translation: "package"), WordPair(original: "чемодан", translation: "suitcase"), WordPair(original: "пакетик", translation: "packet"),  WordPair(original: "пакетик", translation: "packet"), WordPair(original: "пакетик", translation: "packet")],
        ]
        
        var word: String
        
        
        var body: some View {
            VStack {
                HStack {
                    Text(word)
                        .font(.title2)
                        .padding()
                    Spacer()
                }
                .padding(.leading)

                WordInfoView(wordPairs: TranslationBlock.exampleWordPairs)
            }
        }
    }
    
    struct Header: View {
        @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
        
        
        var body: some View {
            HStack {
                Spacer()
                Button {
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title)
                        .padding()
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct WordCard_Previews: PreviewProvider {
    private static let wordPair = WordPair("Bag", "Сумка")
    static var previews: some View {
        WordCard(wordPair: wordPair)
    }
}
