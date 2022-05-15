//
//  WordPairRow.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct WordPairRow: View {
    public let wordPair: WordPair
    @Binding public var learnedWordPairs: [WordPair]
    @Binding public var learningWordPairs: [WordPair]
    
    private let heightRatio = 0.5
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    @State private var linkActive = false
    
    
    var body: some View {
        LazyVGrid(columns: columns) {
            Text(wordPair.Translation)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(wordPair.Original)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(NavigationLink(destination: WordCard(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs), isActive: $linkActive) {
            EmptyView()
        }.opacity(0.0))
    }
}

//struct WordPairRow_Previews: PreviewProvider {
//    private static var wordPair = WordPair(original: ("Bag"), translation: "Сумка")
//    
//    
//    static var previews: some View {
//        WordPairRow(wordPair: wordPair)
//    }
//}
