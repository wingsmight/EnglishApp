//
//  WordPair.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation

struct WordPair : Hashable, Identifiable, Codable {
    private var original: String! = ""
    private var translation: String! = ""
    
    
    internal init(original: String?, translation: String?) {
        self.original = original ?? ""
        self.translation = translation ?? ""
    }
    internal init(_ original: String?, _ translation: String?) {
        self.original = original ?? ""
        self.translation = translation ?? ""
    }
    
    
    public var Original: String! {
        original
    }
    public var Translation: String! {
        translation
    }
    var id: String {
        original
    }
}
