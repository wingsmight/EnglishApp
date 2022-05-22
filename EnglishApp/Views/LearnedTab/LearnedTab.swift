//
//  LearnedTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI


struct LearnedTab: View {
    @Binding public var wordPairs: [WordPair]
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if wordPairs.learnedOnly.isEmpty {
                    Spacer()
                    
                    Text("Вы еще не выучили\nни одного слова 🤔")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach($wordPairs, id: \.self) { wordPair in
                            if wordPair.wrappedValue.state == .learned {
                                LearnedWordPairRow(wordPair: wordPair)
                                    .padding(.vertical, -10)
                            }
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
        .navigationViewStyle(.stack)
    }
    
    
    func moveWordToLearingList(at offsets: IndexSet) {
        offsets.forEach { (i) in
            wordPairs[i].state = .learning
        }
    }
    
    
    struct LearnedWordPairRow: View {
        @Binding public var wordPair: WordPair
        
        
        var body: some View {
            WordPairRow(wordPair: $wordPair)
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
//
//struct LearnedTab_Previews: PreviewProvider {
//    static var previews: some View {
//        LearnedTab()
//    }
//}
