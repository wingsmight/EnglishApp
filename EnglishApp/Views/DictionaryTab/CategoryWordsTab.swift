//
//  CategoryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct CategoryWordsTab: View {
    var categoryLabel: String
    var wordPairs: [WordPair]
    
    
    var body: some View {
        List {
            ForEach(wordPairs, id: \.Original) { wordPair in
                CategoryWordPairRow(wordPair: wordPair)
                    .id(wordPair.id)
            }
        }
        .listStyle(.inset)
        .navigationTitle(categoryLabel)
    }
}


struct CategoryWordPairRow: View {
    var wordPair: WordPair
    
    
    var body: some View {
        HStack {
            WordPairRow(wordPair: wordPair)
            
            ToggleLearningWordButton(wordPair: wordPair)
                .padding(.horizontal, 2)
            
            ToggleLearnedWordButton(wordPair: wordPair)
                .padding(.horizontal, 2)
        }
    }
}

struct CategoryTab_Previews: PreviewProvider {
    private static var wordPairs: [WordPair] = [
        WordPair(original: "Bag", translation: "Сумка"),
        WordPair(original: "Very big bag bag bag", translation: "Очень большая сумка cewjiei frejfierj j wefjijewifi wjeifjweiofjjwefoi wefioewjfio"),
    ]
    
    
    static var previews: some View {
        CategoryWordsTab(categoryLabel: "ТОП 100", wordPairs: wordPairs)
    }
}
