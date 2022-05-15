//
//  WordCard.swift
//  EnglishApp
//
//  Created by Igoryok on 03.05.2022.
//

import SwiftUI


struct WordCard: View {
    public let wordPair: WordPair
    @Binding public var learnedWordPairs: [WordPair]
    @Binding public var learningWordPairs: [WordPair]
    
    
    var body: some View {
        ZStack {
            VStack {
                Header()
                Spacer()
            }
            
            VStack {
                OriginalWordBlock(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
                    .padding(.top, 100)
                WordInfoView(word: .constant(wordPair.Translation))
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
    }
    
    struct OriginalWordBlock: View {
        public let wordPair: WordPair
        @Binding public var learnedWordPairs: [WordPair]
        @Binding public var learningWordPairs: [WordPair]
        
        
        var body: some View {
            HStack {
                Text(wordPair.Original)
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                WordControlPanel(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
                    .padding()
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
//
//struct WordCard_Previews: PreviewProvider {
//    private static let wordPair = WordPair("Bag", "Сумка")
//    static var previews: some View {
//        WordCard(wordPair: wordPair)
//    }
//}
