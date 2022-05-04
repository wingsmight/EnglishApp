//
//  CategoryTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct CategoryWordsTab: View {
    var wordPairs: [WordPair]
    
    
    var body: some View {
        NavigationView {
            if wordPairs.isEmpty {
                Spacer()
                
                Text("Добавьте слова из словаря\nдля начала изучения 💡")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            } else {
                List {
                    ForEach(wordPairs, id: \.Original) { wordPair in
                        CategoryWordPairRow(wordPair: wordPair)
                            .id(wordPair.id)
                    }
                }
                .listStyle(.inset)
            }
        }
    }
}

struct CategoryWordPairRow: View {
    var wordPair: WordPair

    
    var body: some View {
        HStack {
            WordPairRow(wordPair: wordPair)
            
            ToggleCircleImage(image: Image("Bell"), enabledColor: Color("AppYellow"), action: { _ in
                // Action
            })
            .padding(.horizontal, 2)
            
            ToggleCircleImage(image: Image(systemName: "checkmark"), enabledColor: Color("AppGreen"), action: { _ in
                // Action
            })
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
        CategoryWordsTab(wordPairs: wordPairs)
    }
}
