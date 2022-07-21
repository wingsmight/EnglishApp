//
//  Category.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation
import SwiftUI

class LearningCategory: ObservableObject, Hashable, Equatable {
    public var label: Label
    @Published public var wordPairs: [WordPair]
    
    
    internal init(label: LearningCategory.Label, wordPairs: [WordPair]) {
        self.label = label
        self.wordPairs = wordPairs
    }
    
    
    public static func == (lhs: LearningCategory, rhs: LearningCategory) -> Bool {
        return lhs.label == rhs.label
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(label)
        hasher.combine(wordPairs)
    }
    
    
    struct Label: Hashable, Equatable {
        private var iconPath: String
        private var titleText: String
        private var headlineText: String
        private var backgroundColor: Color
        
        
        internal init(iconPath: String, titleText: String, headlineText: String, backgroundColor: Color) {
            self.iconPath = iconPath
            self.titleText = titleText
            self.headlineText = headlineText
            self.backgroundColor = backgroundColor
        }
        
        
        public static func == (lhs: Label, rhs: Label) -> Bool {
            return lhs.titleText == rhs.titleText
        }
        
        
        public var IconPath: String {
            iconPath
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
