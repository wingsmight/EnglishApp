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
    }
}

extension View {
    func colorBadge(count: Int) -> some View {
        overlay(
            ZStack {
                if count != 0 {
                    Circle()
                        .fill(Color.red)
                    Text("\(count)")
                        .foregroundColor(.white)
                        .font(.caption)
                }
            }
                .offset(x: 12, y: -12)
                .frame(width: 24, height: 24)
            , alignment: .topTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
