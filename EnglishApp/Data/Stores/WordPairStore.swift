//
//  WordPairStore.swift
//  EnglishApp
//
//  Created by Igoryok on 15.05.2022.
//

import Foundation
import SwiftUI

class WordPairStore: ObservableObject {
    private static let fileName = "wordPairs.data"
    
    @Published public var wordPairs: [WordPair] = []
    
    
    public var learningWordPairs: [WordPair] {
        wordPairs.filter( { $0.state == .learning } )
    }
    public var learnedWordPairs: [WordPair] {
        wordPairs.filter( { $0.state == .learned } )
    }
    public var pushedWordPairs: [WordPair] {
        wordPairs.filter( { $0.isPushed } )
    }
    public static func load(completion: @escaping (Result<[WordPair], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let wordPairs = try JSONDecoder().decode([WordPair].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(wordPairs))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    public static func save(wordPairs: [WordPair], completion: @escaping (Result<Int, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(wordPairs)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(wordPairs.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent(fileName)
    }
}
