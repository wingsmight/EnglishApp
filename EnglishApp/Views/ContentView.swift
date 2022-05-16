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
    @StateObject private var wordPairStore = WordPairStore()
    @Environment(\.scenePhase) private var scenePhase
    private let tabBadges: [TabBadge] = [
        TabBadge(count: 0, backgroundColor: Color("AppCyan")),
        TabBadge(count: 22, backgroundColor: Color("AppYellow")),
        TabBadge(count: 33, backgroundColor: Color("AppGreen")),
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $selectedTabIndex) {
                    DictionaryTab(wordPairs: $wordPairStore.wordPairs)
                        .tabItem {
                            Label("Словарь", image: "CategoryTabIcon")
                        }
                    
                    LearningTab(wordPairs: $wordPairStore.wordPairs)
                        .tabItem {
                            Label("На изучении", image: "LearningTabIcon")
                        }
                    
                    LearnedTab(wordPairs: $wordPairStore.wordPairs)
                        .tabItem {
                            Label("Выученные", image: "LearnedTabIcon")
                        }
                }
                
                ColorfulBadgeList(tabBadges: tabBadges, geometry: geometry)
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear {
            WordPairStore.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let wordPairs):
                    wordPairStore.wordPairs = wordPairs
                }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                WordPairStore.save(wordPairs: wordPairStore.wordPairs) { result in
                    if case .failure(let error) = result {
                        fatalError(error.localizedDescription)
                    }
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
