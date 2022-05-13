//
//  Word.swift
//  EnglishApp
//
//  Created by Igoryok on 10.05.2022.
//

import Foundation

struct Word: Decodable {
    private let word: String
    
    public let synonyms: [[String]]?
    public let examples: [String]?
}
