//
//  RussianSynonymsApi.swift
//  EnglishApp
//
//  Created by Igoryok on 02.07.2022.
//

import Foundation
import SwiftUI

@MainActor
class RussianSynonymsApi: ObservableObject, ISynonymsApi {
    private let baseUrl = "https://synonymonline.ru/"
    
    @Published public var synonymLists: [[String]] = []
    @Published public var isLoaded = false
    
    
    public func loadSynonyms(word: String) async {
        synonymLists = []
        isLoaded = false
        
        if word.isEmpty {
            return
        }
        
        let handledRaw = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if handledRaw.isEmpty {
            return
        }
        let url = (baseUrl + handledRaw.first!.uppercased() + "/" + handledRaw).encodeUrl
        
        let fullHtml: String
        do {
            fullHtml = try await url.getHtml()
        } catch {
            return
        }
        
        let subHtml = fullHtml
        var synonyms: [String] = []

        let startSynonymRowPattern = "<ol class=\"list-words list-columns\"> <li>"
        let endSynonymRowPattern = "</li> </ol>"
        let maxSynonymListLength = 2
        let maxSynonymInListLength = 3
        
        if let range = subHtml.range(of: startSynonymRowPattern) {
            let firstIndex = range.upperBound
            if let end = subHtml[firstIndex...].range(of: endSynonymRowPattern) {
                let range = firstIndex..<end.lowerBound
                
                let synonymList = String(subHtml[range])
                
                synonyms = synonymList.components(separatedBy: "</li><li>")
            } else {
                isLoaded = true
                
                return
            }
        } else {
            isLoaded = true
            
            return
        }

        var synonymIndex = 0
        for _ in 0..<maxSynonymListLength {
            let endSubSynonymIndex = min(synonymIndex + maxSynonymInListLength, synonyms.count)
            if synonymIndex < endSubSynonymIndex {
                let subSynonyms = Array(synonyms[synonymIndex..<endSubSynonymIndex])
                synonymLists.append([])
                synonymLists[synonymLists.count - 1] = subSynonyms
                synonymIndex += maxSynonymInListLength
            }
        }
        
        isLoaded = true
        
        print(synonymLists)
    }
}
