//
//  LearnedTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearnedTab: View {
    @State var wordPairs: [WordPair] = [
        WordPair(original: "Bag", translation: "Сумка"),
        WordPair(original: "Very big bag", translation: "Очень большая сумка"),
    ]
    
    var body: some View {
        VStack {
            Header()
            
            if wordPairs.isEmpty {
                Spacer()
                
                Text("Вы еще не выучили\nни одного слова 🤔")
                    .multilineTextAlignment(.center)
                    .padding()
                
                Spacer()
            } else {
                List {
                    ForEach(wordPairs) { wordPair in
                        WordPairRow(wordPair: wordPair)
                    }
                }
                .listStyle(.inset)
                
                Button {
                    // Action
                } label: {
                    RepeatWordsButton()
                }
                .buttonStyle(RoundedRectangleButtonStyle(color: .green))
                .padding()
            }
        }
    }
    
    struct RepeatWordsButton: View {
        var body: some View {
            HStack {
                Spacer()
                Image(systemName: "checkmark.circle")
                    .font(.title)
                Text("Повторить слова")
                    .bold()
                Spacer()
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
    struct SettingsView: View {
        var body: some View {
            Image(systemName: "slider.horizontal.3")
                .padding()
                .font(.title)
        }
    }
}

struct LearnedTab_Previews: PreviewProvider {
    static var previews: some View {
        LearnedTab()
    }
}
