//
//  WordCard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI


struct WordCard: View {
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
            }
            
            VStack {
                OriginalWordBlock()
                    .padding(.top, 100)
                TranslationBlock()
                Spacer()
            }
        }
    }
    
    struct OriginalWordBlock: View {
        var body: some View {
            HStack {
                Text("bag")
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
        private var exampleWordPairs: [[WordPair]] = [
            [WordPair(original: "сумка", translation: "handbag"), WordPair(original: "чехол", translation: "case"), WordPair(original: "сумочка", translation: "case")],
            [WordPair(original: "мешок", translation: "pouch"), WordPair(original: "пакет", translation: "package"), WordPair(original: "чемодан", translation: "suitcase"), WordPair(original: "пакетик", translation: "packet"),  WordPair(original: "пакетик", translation: "packet"), WordPair(original: "пакетик", translation: "packet")],
        ]
        
        var body: some View {
            VStack {
                HStack {
                    Text("Сумка")
                        .font(.title2)
                        .padding()
                    Spacer()
                }
                .padding(.leading)

                WordInfoView(wordPairs: exampleWordPairs)
            }
        }
    }
    
    struct Header: View {
        var body: some View {
            HStack {
                Spacer()
                Button {
                    // Action
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
    static var previews: some View {
        WordCard()
    }
}
