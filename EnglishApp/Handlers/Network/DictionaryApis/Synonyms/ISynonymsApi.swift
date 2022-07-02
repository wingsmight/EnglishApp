//
//  SynonymsApi.swift
//  EnglishApp
//
//  Created by Igoryok on 02.07.2022.
//

import Foundation

public protocol ISynonymsApi {
    var synonymLists: [[String]] { get }
    var isLoaded: Bool { get }
    
    
    func loadSynonyms(word: String) async
}
