//
//  WordPair.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation

struct WordPair : Hashable, Identifiable, Codable, Equatable {
    private var original: String! = ""
    private var translation: String! = ""
    
    
    internal init(original: String?, translation: String?) {
        self.init(original, translation)
    }
    internal init(_ original: String?, _ translation: String?) {
        self.original = original ?? ""
        self.translation = translation ?? ""
    }
    
    
    public func containsAny(of word: String) -> Bool {
        return original == word || translation == word
    }
    public static func == (lhs: WordPair, rhs: WordPair) -> Bool {
        return
            lhs.Original == rhs.Original &&
            lhs.Translation == rhs.Translation
    }
    
    
    public var Original: String! {
        original
    }
    public var Translation: String! {
        translation
    }
    public var id: String {
        original
    }
}
