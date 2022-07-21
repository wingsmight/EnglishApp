//
//  LearnedTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI


struct LearnedTab: View {
    @Binding public var badge: TabBadge
    
    @EnvironmentObject private var wordPairStore: WordPairStore
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if wordPairStore.wordPairs.learnedOnly.isEmpty {
                    Spacer()
                    
                    Text("Вы еще не выучили\nни одного слова 🤔")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach($wordPairStore.wordPairs.sorted(by: { $0.wrappedValue.ChangingDate > $1.wrappedValue.ChangingDate }),
                                id: \.id) { (wordPair: Binding<WordPair>) in
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
        .onChanged(of: wordPairStore.wordPairs.learnedOnly) { words in
            badge.count = words.count
        }
    }
    
    
    func moveWordToLearingList(at offsets: IndexSet) {
        offsets.forEach { (i) in
            wordPairStore.wordPairs[i].State = .learning
        }
    }
    
    
    struct LearnedWordPairRow: View {
        @Binding public var wordPair: WordPair
        
        
        var body: some View {
            WordPairRow(wordPair: $wordPair)
        }
    }
    
    struct RepeatWordsButton: View {
        @EnvironmentObject private var wordPairStore: WordPairStore
        @State private var linkActive: Bool = false
        
        
        var body: some View {
            Button {
                linkActive.toggle()
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
            .background(NavigationLink(destination: TestView(model: TestModel(wordPairs: wordPairStore.wordPairs)), isActive: $linkActive) {
                EmptyView()
            }
                .isDetailLink(false)
                .opacity(0.0)
            )
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
