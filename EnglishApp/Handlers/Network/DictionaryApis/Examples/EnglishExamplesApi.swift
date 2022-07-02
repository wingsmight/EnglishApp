//
//  ExamplesApi.swift
//  EnglishApp
//
//  Created by Igoryok on 10.05.2022.
//

import Foundation
import SwiftUI

@MainActor
final class EnglishExamplesApi: ObservableObject, IExamplesApi {
    private let baseUrl = "https://www.wordreference.com/definition/"
    
    @Published public var examples: [String] = []
    @Published public var isLoaded = false
    
    
    public func loadExamples(word: String) async {
        examples = []
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
        
        var subHtml = fullHtml.suffix(Int(Double(fullHtml.count) / 1.5))
        
        let startExampleRowPattern = "rh_ex\'>"
        let endExampleRowPattern = "</span><"
        let maxExampleLength = 3
        
        var gainedExamples: [String] = []
        for _ in 0..<maxExampleLength {
            if let range = subHtml.range(of: startExampleRowPattern) {
                var firstIndex = range.upperBound
                if subHtml[firstIndex...].starts(with: "<span class") {
                    if let range = subHtml[firstIndex...].range(of: "]</span></span>") {
                        firstIndex = range.upperBound
                    }
                }
                
                if let end = subHtml[firstIndex...].range(of: endExampleRowPattern) {
                    let range = firstIndex..<end.lowerBound
                    
                    let example = String(subHtml[range])

                    gainedExamples.append(example)

                    subHtml = subHtml[end.upperBound...]
                } else {
                    break
                }
            } else {
                break
            }
        }
        
        examples = gainedExamples
        print("\(examples) for \(word)")
        isLoaded = true
    }
}
