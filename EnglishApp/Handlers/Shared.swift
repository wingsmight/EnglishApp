//
//  Shared.swift
//  EnglishApp
//
//  Created by Igoryok on 07.05.2022.
//

import Foundation

class Shared {
    static let instance = Shared()
    
    
    var learningWordPairs: [WordPair] {
        get {
            guard let data = try? Data(contentsOf: .getStoredData(fileName: "learningWordPairs")) else { return [] }
            return (try? JSONDecoder().decode([WordPair].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .getStoredData(fileName: "learningWordPairs"))
        }
    }
    var learnedWordPairs: [WordPair] {
        get {
            guard let data = try? Data(contentsOf: .getStoredData(fileName: "learnedWordPairs")) else { return [] }
            return (try? JSONDecoder().decode([WordPair].self, from: data)) ?? []
        }
        set {
            try? JSONEncoder().encode(newValue).write(to: .getStoredData(fileName: "learnedWordPairs"))
        }
    }
    
    
    private init() { }
}
