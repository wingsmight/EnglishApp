//
//  ContentView.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var colorScheme = Theme.colorScheme
    @State private var selectedTabIndex = 1
    
    @StateObject private var learningWordPairStore = LearningWordPairStore()
    @StateObject private var learnedWordPairStore = LearnedWordPairStore()
    @StateObject private var pushedWordPairStore = PushedWordPairStore()
    
    private let tabBadges: [TabBadge] = [
        TabBadge(count: 0, backgroundColor: Color("AppCyan")),
        TabBadge(count: 22, backgroundColor: Color("AppYellow")),
        TabBadge(count: 33, backgroundColor: Color("AppGreen")),
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $selectedTabIndex) {
                    DictionaryTab(learningWordPairs: $learningWordPairStore.wordPairs, learnedWordPairs: $learnedWordPairStore.wordPairs, saveAction: {
                        LearningWordPairStore.save(wordPairs: learningWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                        LearnedWordPairStore.save(wordPairs: learnedWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    })
                        .tabItem {
                            Label("Словарь", image: "CategoryTabIcon")
                        }
                    
                    LearningTab(learningWordPairs: $learningWordPairStore.wordPairs, learnedWordPairs: $learnedWordPairStore.wordPairs, pushedWordPairs: $pushedWordPairStore.wordPairs, saveAction: {
                        LearningWordPairStore.save(wordPairs: learningWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                        LearnedWordPairStore.save(wordPairs: learnedWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                        PushedWordPairStore.save(wordPairs: pushedWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    })
                        .tabItem {
                            Label("На изучении", image: "LearningTabIcon")
                        }
                    
                    LearnedTab(learnedWordPairs: $learnedWordPairStore.wordPairs, learningWordPairs: $learningWordPairStore.wordPairs, saveAction: {
                        LearnedWordPairStore.save(wordPairs: learnedWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                        
                        LearningWordPairStore.save(wordPairs: learningWordPairStore.wordPairs) { result in
                            if case .failure(let error) = result {
                                fatalError(error.localizedDescription)
                            }
                        }
                    })
                        .tabItem {
                            Label("Выученные", image: "LearnedTabIcon")
                        }
                }
                
                ColorfulBadgeList(tabBadges: tabBadges, geometry: geometry)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            LearningWordPairStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let wordPairs):
                    learningWordPairStore.wordPairs = wordPairs
                }
            }
            
            LearnedWordPairStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let wordPairs):
                    learnedWordPairStore.wordPairs = wordPairs
                }
            }
            
            PushedWordPairStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let wordPairs):
                    pushedWordPairStore.wordPairs = wordPairs
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
