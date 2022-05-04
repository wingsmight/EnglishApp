//
//  Category.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation
import SwiftUI

struct LearningCategory {
    private var label: Label
    private var wordPairs: [WordPair]
    
    
    internal init(label: LearningCategory.Label, wordPairs: [WordPair]) {
        self.label = label
        self.wordPairs = wordPairs
    }
    
    
    public var Label: Label {
        label
    }
    public var WordPairs: [WordPair] {
        wordPairs
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
