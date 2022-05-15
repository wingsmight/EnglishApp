//
//  ColorfulBadge.swift
//  EnglishApp
//
//  Created by Igoryok on 05.05.2022.
//

import SwiftUI


struct ColorfulBadgeList: View {
    var tabBadges: [TabBadge]
    var geometry: GeometryProxy
    
    
    internal init(tabBadges: [TabBadge], geometry: GeometryProxy) {
        self.tabBadges = tabBadges
        self.geometry = geometry
    }
    
    
    var body: some View {
        ForEach(0..<tabBadges.count, id: \.self) { tabIndex in
            ColorfulBadge(tabIndex: tabIndex, tabCount: tabBadges.count, tabBadge: tabBadges[tabIndex], geometry: geometry)
        }
    }
}

struct ColorfulBadge: View {
    var tabIndex: Int
    var tabCount: Int
    var tabBadge: TabBadge
    var geometry: GeometryProxy
    
    
    var body: some View {
        HStack {
            Text("\(tabBadge.count)")
                .foregroundColor(.black)
                .font(Font.system(size: 12))
                .multilineTextAlignment(.leading)
                .background {
                    Capsule()
                        .foregroundColor(tabBadge.backgroundColor)
                        .padding(.horizontal, -6)
                        .padding(.vertical, -1)
                }
            
            Spacer()
        }
        .frame(width: 40, height: 20)
        .frame(minWidth: 20, maxWidth: 40, minHeight: 20, maxHeight: 20)
        .offset(x: calcOffset(tabIndex, geometry.size.width, tabCount), y: -26)
        .opacity(tabBadge.count <= 0 ? 0 : 1)
        .allowsHitTesting(false)
    }
}

struct TabBadge {
    var count: Int
    var backgroundColor: Color
}

func calcOffset(_ badgeIndex: Int, _ viewWidth: CGFloat, _ tabCount: Int) -> CGFloat {
    4.0 + ((2.0 * CGFloat(badgeIndex)) + 1.0) * (viewWidth / (2.0 * CGFloat(tabCount)))
}

//struct ColorfulBadge_Previews: PreviewProvider {
//    private static let tabBadges: [TabBadge] = [
//        TabBadge(count: 11, backgroundColor: Color("AppCyan")),
//        TabBadge(count: 22, backgroundColor: Color("AppYellow")),
//        TabBadge(count: 33, backgroundColor: Color("AppGreen")),
//    ]
//    
//    
//    static var previews: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .bottomLeading) {
//                TabView {
//                    DictionaryTab()
//                        .tabItem {
//                            Label("Словарь", image: "CategoryTabIcon")
//                        }
//                    
//                    LearningTab()
//                        .tabItem {
//                            Label("На изучении", image: "LearningTabIcon")
//                        }
//                    
//                    LearnedTab()
//                        .tabItem {
//                            Label("Выученные", image: "LearnedTabIcon")
//                        }
//                }
//                
//                ColorfulBadgeList(tabBadges: tabBadges, geometry: geometry)
//            }
//        }
//    }
//}
