//
//  Category.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation
import SwiftUI

class LearningCategory: ObservableObject {
    public var label: Label
    @Published public var wordPairs: [WordPair]
    
    
    internal init(label: LearningCategory.Label, wordPairs: [WordPair], generalWordPairs: Binding<[WordPair]>) {
        self.label = label
        
        self.wordPairs = generalWordPairs.wrappedValue.filter( { wordPairs.contains($0) } )
        self.wordPairs += wordPairs.filter( { !generalWordPairs.wrappedValue.contains($0) } )
    }
    
    
    struct Label {
        private var iconName: String
        private var titleText: String
        private var headlineText: String
        private var backgroundColor: Color
        
        
        internal init(iconName: String, titleText: String, headlineText: String, backgroundColor: Color) {
            self.iconName = iconName
            self.titleText = titleText
            self.headlineText = headlineText
            self.backgroundColor = backgroundColor
        }
        
        
        public var IconName: String {
            iconName
        }
        public var TitleText: String {
            titleText
        }
        public var HeadlineText: String {
            headlineText
        }
        public var BackgroundColor: Color {
            backgroundColor
        }
    }
}
