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
        NavigationView {
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
                            LearnedWordPairRow(wordPair: wordPair)
                                .padding(.vertical, -10)
                        }
                    }
                    .listStyle(.inset)
                    
                    RepeatWordsButton()
                        .padding()
                }
            }
            .navigationBarTitle("Выученные")
            .navigationBarHidden(true)
        }
    }
    
    struct LearnedWordPairRow: View {
        var wordPair: WordPair
        
        
        var body: some View {
            NavigationLink(destination: WordCard(wordPair: wordPair)) {
                WordPairRow(wordPair: wordPair)
            }
        }
    }
    
    struct RepeatWordsButton: View {
        var body: some View {
            Button {
                // Action
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "checkmark.circle")
                        .font(.title)
                    Text("Повторить слова")
                        .bold()
                    Spacer()
                }
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .green))
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
