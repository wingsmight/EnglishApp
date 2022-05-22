//
//  CategoryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct CategoryWordsTab: View {
    public var categoryLabel: String
    @Binding public var categoryWordPairs: [WordPair]
    @Binding public var wordPairs: [WordPair]
    
    
    var body: some View {
        List {
            ForEach($wordPairs, id: \.self) { wordPair in
                if categoryWordPairs.contains(wordPair.wrappedValue) {
                    CategoryWordPairRow(wordPair: wordPair)
                }
            }
        }
        .listStyle(.inset)
        .navigationTitle(categoryLabel)
    }
}


struct CategoryWordPairRow: View {
    @Binding public var wordPair: WordPair
    
    
    var body: some View {
        HStack {
            WordPairRow(wordPair: $wordPair)
            
            ToggleLearningWordButton(wordPair: Binding<WordPair?>($wordPair))
                .padding(.horizontal, 2)
            
            ToggleLearnedWordButton(wordPair: Binding<WordPair?>($wordPair))
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
