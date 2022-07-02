//
//  SynonymsApi.swift
//  EnglishApp
//
//  Created by Igoryok on 10.05.2022.
//

import Foundation
import SwiftUI

class EnglishSynonymsApi: ObservableObject, ISynonymsApi {
    private let baseUrl = "https://www.wordreference.com/synonyms/"
    
    @Published public var synonymLists: [[String]] = []
    @Published public var isLoaded = false
    
    
    public func loadSynonyms(word: String) async {
        synonymLists = []
        isLoaded = false
        
        var handledRaw = word.trimmingCharacters(in: .whitespacesAndNewlines)
        handledRaw = handledRaw.replacingOccurrences(of: " ", with: "%20")
        let url = baseUrl + handledRaw
        
        let fullHtml: String
        do {
            fullHtml = try await url.getHtml()
        } catch {
            return
        }
        
        var subHtml = fullHtml.suffix(Int(Double(fullHtml.count) / 2.0))
        var synonymRows: [String] = []
        
        let startSynonymRowPattern = "text-decoration: underline;'>Synonyms:</div><div style='margin-left: 40px;'>"
        let endSynonymRowPattern = "</div>"
        let maxSynonymListLength = 2
        let maxSynonymInListLength = 3

        for _ in 0..<maxSynonymListLength {
            if let range = subHtml.range(of: startSynonymRowPattern) {
                let firstIndex = range.upperBound
                if let end = subHtml[firstIndex...].range(of: endSynonymRowPattern) {
                    let range = firstIndex..<end.upperBound
                    
                    synonymRows.append(String(subHtml[range]))
                    
                    subHtml = subHtml[end.upperBound...]
                } else {
                    break
                }
            } else {
                break
            }
        }
        
        let synonymTag = ("<span>", "</span>")
        
        synonymLists = []
        
        for synonymRow in synonymRows {
            let synonyms: [String] = synonymRow.sliceMultipleTimes(from: synonymTag.0, to: synonymTag.1)
            let atLeastFirst3Synonyms: [String] = Array(synonyms[..<maxSynonymInListLength])
            synonymLists.append(atLeastFirst3Synonyms)
        }
        
        isLoaded = true
    }
}
