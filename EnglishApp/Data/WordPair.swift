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
    public var original: String = ""
    public var translation: String = ""
    
    private var changingDate: Date = Date.now


    internal init(original: String, translation: String) {
        self.init(original, translation)
    }
    internal init(_ original: String, _ translation: String) {
        self.original = original
        self.translation = translation
    }


    public func containsAny(of word: String) -> Bool {
        Original.lowercased() == word.lowercased() || Translation.lowercased() == word.lowercased()
    }
    public static func == (lhs: WordPair, rhs: WordPair) -> Bool {
        return
            lhs.Original.lowercased() == rhs.Original.lowercased() &&
            lhs.Translation.lowercased() == rhs.Translation.lowercased()
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(Original.lowercased())
        hasher.combine(Translation.lowercased())
    }
    
    
    public var id: String {
        Original.lowercased() + Translation.lowercased()
    }
    public var State: State {
        get {
            state
        }
        set {
            changingDate = Date.now
            state = newValue
        }
    }
    public var IsPushed: Bool {
        get {
            isPushed
        }
        set {
            changingDate = Date.now
            isPushed = newValue
        }
    }
    public var Original: String {
        get {
            original
        }
        set {
            changingDate = Date.now
            original = newValue
        }
    }
    public var Translation: String {
        get {
            translation
        }
        set {
            changingDate = Date.now
            translation = newValue
        }
    }
    public var ChangingDate: Date {
        changingDate
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
        filter( { $0.State == .learning } )
    }
    var learnedOnly: [WordPair] {
        filter( { $0.State == .learned } )
    }
    var pushedOnly: [WordPair] {
        filter( { $0.IsPushed } )
    }
}
