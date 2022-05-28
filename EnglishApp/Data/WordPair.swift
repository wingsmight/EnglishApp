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


    internal init(original: String, translation: String) {
        self.init(original, translation)
    }
    internal init(_ original: String, _ translation: String) {
        self.original = original
        self.translation = translation
    }


    public func containsAny(of word: String) -> Bool {
        original.lowercased() == word.lowercased() || translation.lowercased() == word.lowercased()
    }
    public static func == (lhs: WordPair, rhs: WordPair) -> Bool {
        return
            lhs.original.lowercased() == rhs.original.lowercased() &&
            lhs.translation.lowercased() == rhs.translation.lowercased()
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(original.lowercased())
        hasher.combine(translation.lowercased())
    }
    
    
    public var id: String {
        original.lowercased() + translation.lowercased()
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

////
////  WordPair.swift
////  EnglishApp
////
////  Created by Igoryok on 02.05.2022.
////
//
//import Foundation
//import SwiftUI
//
//class WordPair : ObservableObject, Codable, Hashable, Equatable {
//    @Published public var state: State = .none
//    @Published public var isPushed: Bool = false
//
//    @Published public var original: String = ""
//    @Published public var translation: String = ""
//
//
//    internal convenience init(original: String, translation: String) {
//        self.init(original, translation)
//    }
//    internal init(_ original: String, _ translation: String) {
//        self.original = original
//        self.translation = translation
//    }
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        state = try values.decode(State.self, forKey: .state)
//        isPushed = try values.decode(Bool.self, forKey: .isPushed)
//        original = try values.decode(String.self, forKey: .original)
//        translation = try values.decode(String.self, forKey: .translation)
//    }
//
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(state, forKey: .state)
//        try container.encode(isPushed, forKey: .isPushed)
//        try container.encode(original, forKey: .original)
//        try container.encode(translation, forKey: .translation)
//    }
//    public func containsAny(of word: String) -> Bool {
//        original.lowercased() == word.lowercased() || translation.lowercased() == word.lowercased()
//    }
//    public static func == (lhs: WordPair, rhs: WordPair) -> Bool {
//        return
//            lhs.original.lowercased() == rhs.original.lowercased() &&
//            lhs.translation.lowercased() == rhs.translation.lowercased()
//    }
//    public func hash(into hasher: inout Hasher) {
//        hasher.combine(original.lowercased())
//        hasher.combine(translation.lowercased())
//    }
//
//
//    public var Original: String {
//        original
//    }
//    public var Translation: String {
//        translation
//    }
//
//
//    enum CodingKeys: CodingKey {
//        case state
//        case isPushed
//        case original
//        case translation
//    }
//    public enum State: Int, Codable {
//        case none,
//             learning,
//             learned
//
//
//        public init(from decoder: Decoder) throws {
//            self = try State(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .none
//        }
//    }
//}
//
//extension Array where Element == WordPair {
//    var learningOnly: [WordPair] {
//        filter( { $0.state == .learning } )
//    }
//    var learnedOnly: [WordPair] {
//        filter( { $0.state == .learned } )
//    }
//    var pushedOnly: [WordPair] {
//        filter( { $0.isPushed } )
//    }
//}
