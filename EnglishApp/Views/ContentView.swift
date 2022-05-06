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
    
    private let tabBadges: [TabBadge] = [
        TabBadge(count: 0, backgroundColor: Color("AppCyan")),
        TabBadge(count: 22, backgroundColor: Color("AppYellow")),
        TabBadge(count: 33, backgroundColor: Color("AppGreen")),
    ]
    
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading) {
                TabView(selection: $selectedTabIndex) {
                    DictionaryTab()
                        .tabItem {
                            Label("Словарь", image: "CategoryTabIcon")
                        }
                    
                    LearningTab()
                        .tabItem {
                            Label("На изучении", image: "LearningTabIcon")
                        }
                    
                    LearnedTab()
                        .tabItem {
                            Label("Выученные", image: "LearnedTabIcon")
                        }
                }
                
                ColorfulBadgeList(tabBadges: tabBadges, geometry: geometry)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
