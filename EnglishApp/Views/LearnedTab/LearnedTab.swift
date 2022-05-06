//
//  LearnedTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearnedTab: View {   
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if Shared.instance.learnedWordPairs.isEmpty {
                    Spacer()
                    
                    Text("Вы еще не выучили\nни одного слова 🤔")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(Shared.instance.learnedWordPairs) { wordPair in
                            LearnedWordPairRow(wordPair: wordPair)
                                .padding(.vertical, -10)
                        }
                        .onDelete(perform: moveWordToLearingList)
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
    
    
    func moveWordToLearingList(at offsets: IndexSet) {
        offsets.forEach { (i) in
            Shared.instance.learningWordPairs.append(Shared.instance.learnedWordPairs[i])
        }
        
        Shared.instance.learnedWordPairs.remove(at: offsets);
    }
    
    
    struct LearnedWordPairRow: View {
        var wordPair: WordPair
        
        
        var body: some View {
            WordPairRow(wordPair: wordPair)
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
            NavigationLink(destination: TestSettingsTab()) {
                Image(systemName: "slider.horizontal.3")
                    .font(.title)
                    .padding()
                    .navigationBarTitle("Выученные")
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct LearnedTab_Previews: PreviewProvider {
    static var previews: some View {
        LearnedTab()
    }
}
