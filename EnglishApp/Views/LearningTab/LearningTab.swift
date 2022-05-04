//
//  LearningTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearningTab: View {
    @State var wordPairs: [WordPair] = [
        WordPair(original: "Bag", translation: "Сумка"),
        WordPair(original: "Very big bag", translation: "Очень большая сумка"),
    ]
    
    var body: some View {
        VStack {
            Header()
            
            if wordPairs.isEmpty {
                Spacer()
                
                Text("Добавьте слова из словаря\nдля начала изучения 💡")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            } else {
                List {
                    ForEach(wordPairs, id: \.Original) { wordPair in
                        LearningWordPairRow(wordPair: wordPair)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    struct LearningWordPairRow: View {
        var wordPair: WordPair

        
        var body: some View {
            HStack {
                WordPairRow(wordPair: wordPair)
                
                Spacer()
                
                Image(systemName: "play")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 22)
                    .padding(.horizontal, 5)
                Image("Checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 20)
                    .padding(.horizontal, 5)
            }
        }
    }
    
    struct Header: View {
        var body: some View {
            ZStack {
                HStack {
                    Spacer()
                    SettingsView()
                }
            }
        }
    }
}

struct LearningTab_Previews: PreviewProvider {
    static var previews: some View {
        LearningTab()
    }
}
