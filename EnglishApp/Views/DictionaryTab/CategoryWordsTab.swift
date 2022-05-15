//
//  CategoryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct CategoryWordsTab: View {
    public var categoryLabel: String
    public var wordPairs: [WordPair]
    @Binding public var learningWordPairs: [WordPair]
    @Binding public var learnedWordPairs: [WordPair]
    
    
    var body: some View {
        List {
            ForEach(wordPairs, id: \.Original) { wordPair in
                CategoryWordPairRow(wordPair: wordPair, learningWordPairs: $learningWordPairs, learnedWordPairs: $learnedWordPairs)
                    .id(wordPair.id)
            }
        }
        .listStyle(.inset)
        .navigationTitle(categoryLabel)
    }
}


struct CategoryWordPairRow: View {
    public let wordPair: WordPair
    @Binding public var learningWordPairs: [WordPair]
    @Binding public var learnedWordPairs: [WordPair]
    
    
    var body: some View {
        HStack {
            WordPairRow(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
            
            ToggleLearningWordButton(wordPair: wordPair, learningWordPairs: $learningWordPairs)
                .padding(.horizontal, 2)
            
            ToggleLearnedWordButton(wordPair: wordPair, learnedWordPairs: $learnedWordPairs)
                .padding(.horizontal, 2)
        }
    }
}

//struct CategoryTab_Previews: PreviewProvider {
//    private static var wordPairs: [WordPair] = [
//        WordPair(original: "Bag", translation: "Сумка"),
//        WordPair(original: "Very big bag bag bag", translation: "Очень большая сумка cewjiei frejfierj j wefjijewifi wjeifjweiofjjwefoi wefioewjfio"),
//    ]
//
//
//    static var previews: some View {
//        CategoryWordsTab(categoryLabel: "ТОП 100", wordPairs: wordPairs, learningWordPairs: <#T##Binding<[WordPair]>#>, learnedWordPairs: <#T##Binding<[WordPair]>#>)
//    }
//}
