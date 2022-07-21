//
//  ContentView.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import SwiftUI

struct ContentView: View {
    private let dictionaryTabIndex = 0
    private let learningTabIndex = 1
    private let learnedTabIndex = 2
    
    @State private var colorScheme = Theme.colorScheme
    @State private var selectedTabIndex = 0
    @StateObject private var wordPairStore = WordPairStore()
    @Environment(\.scenePhase) private var scenePhase
    @State private var tabBadges: [TabBadge] = [
        TabBadge(count: 0, backgroundColor: Color("AppCyan")),
        TabBadge(count: 0, backgroundColor: Color("AppYellow")),
        TabBadge(count: 0, backgroundColor: Color("AppGreen")),
    ]
    @StateObject private var dictionaryModel = DictionaryTab.DictionaryTabModel()
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $selectedTabIndex) {
                    DictionaryTab(model: dictionaryModel)
                        .tabItem {
                            Label("Словарь", image: "CategoryTabIcon")
                        }
                        .tag(dictionaryTabIndex)
                    
                    LearningTab(badge: $tabBadges[learningTabIndex])
                        .tabItem {
                            Label("На изучении", image: "LearningTabIcon")
                        }
                        .tag(learningTabIndex)
                    
                    LearnedTab(badge: $tabBadges[learnedTabIndex])
                        .tabItem {
                            Label("Выученные", image: "LearnedTabIcon")
                        }
                        .tag(learnedTabIndex)
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
                    
                    loadLearningCategories()
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
        .environmentObject(wordPairStore)
    }
    
    func loadLearningCategories() {
        if let asset = NSDataAsset(name: "TestLearningCategories") {
            let data = asset.data
            
            dictionaryModel.categories = (try? ExcelParser.getLearningCategories(data: data)) ?? []
            
            print("before: \(wordPairStore.wordPairs)")
            for category in dictionaryModel.categories {
                for wordPair in category.wordPairs {
                    wordPairStore.wordPairs.appendIfNotContains(wordPair)
                }
            }
            print("after: \(wordPairStore.wordPairs)")
            print("after categories[0]: \(dictionaryModel.categories[0].wordPairs)")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
