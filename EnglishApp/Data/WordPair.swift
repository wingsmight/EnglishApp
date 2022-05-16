//
//  WordPair.swift
//  EnglishApp
//
//  Created by Igoryok on 02.05.2022.
//

import Foundation
import SwiftUI

struct WordPair : Hashable, Identifiable, Codable, Equatable {
    public var state: State = .none
    public var isPushed: Bool = false
    
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
            lhs.Original.lowercased() == rhs.Original.lowercased() &&
            lhs.Translation.lowercased() == rhs.Translation.lowercased()
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
    
    
    public enum State: Int, Codable {
        case none,
             learning,
             learned
        
        
        public init(from decoder: Decoder) throws {
            self = try State(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .none
        }
    }
}

extension Array where Element == WordPair {
    var learningOnly: [WordPair] {
        filter( { $0.state == .learning } )
    }
    var learnedOnly: [WordPair] {
        filter( { $0.state == .learned } )
    }
    var pushedOnly: [WordPair] {
        filter( { $0.isPushed } )
    }
}
