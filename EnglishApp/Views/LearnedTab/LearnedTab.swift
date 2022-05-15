//
//  LearnedTab.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct LearnedTab: View {
    @Binding public var learnedWordPairs: [WordPair]
    @Binding public var learningWordPairs: [WordPair]
    public let saveAction: () -> Void
    
    @Environment(\.scenePhase) private var scenePhase
    
    
    var body: some View {
        NavigationView {
            VStack {
                Header()
                
                if learnedWordPairs.isEmpty {
                    Spacer()
                    
                    Text("Вы еще не выучили\nни одного слова 🤔")
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Spacer()
                } else {
                    List {
                        ForEach(learnedWordPairs, id: \.id) { wordPair in
                            LearnedWordPairRow(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
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
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                saveAction()
            }
        }
    }
    
    
    func moveWordToLearingList(at offsets: IndexSet) {
        offsets.forEach { (i) in
            learningWordPairs.append(learnedWordPairs[i])
        }
        
        learnedWordPairs.remove(at: offsets);
    }
    
    
    struct LearnedWordPairRow: View {
        public let wordPair: WordPair
        @Binding public var learnedWordPairs: [WordPair]
        @Binding public var learningWordPairs: [WordPair]
        
        
        var body: some View {
            WordPairRow(wordPair: wordPair, learnedWordPairs: $learnedWordPairs, learningWordPairs: $learningWordPairs)
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
