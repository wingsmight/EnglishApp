//
//  RussianExamplesApi.swift
//  EnglishApp
//
//  Created by Igoryok on 02.07.2022.
//

import Foundation
import SwiftUI

@MainActor
final class RussianExamplesApi: ObservableObject, IExamplesApi {
    private let baseUrl = "https://lexicography.online/explanatory/"
    
    @Published public var examples: [String] = []
    @Published public var isLoaded = false
    
    
    public func loadExamples(word: String) async {
        examples = []
        isLoaded = false
        
        if word.isEmpty {
            return
        }
        
        let handledRaw = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if handledRaw.isEmpty {
            return
        }
        let url = (baseUrl + String(handledRaw.first!) + "/" + handledRaw).encodeUrl
        
        let fullHtml: String
        do {
            fullHtml = try await url.getHtml()
        } catch {
            print(error)
            return
        }
        
        var subHtml = fullHtml.suffix(fullHtml.count)
        
        let startExampleRowPattern = "<i>"
        let endExampleRowPattern = "</i>"
        let maxExampleLength = 3
        var exampleCount = 0
        
        while exampleCount < maxExampleLength {
            if let range = subHtml.range(of: startExampleRowPattern) {
                let firstIndex = range.upperBound
                if let end = subHtml[firstIndex...].range(of: endExampleRowPattern) {
                    let range = firstIndex..<end.lowerBound
                    
                    let example = String(subHtml[range])
                    
                    if let firstExampleLetter = example.first {
                        if firstExampleLetter.isUppercase && example.count > 12 {
                            examples.append(example)
                            exampleCount += 1
                        }
                        
                        subHtml = subHtml[end.upperBound...]
                    }
                } else {
                    break
                }
            } else {
                break
            }
        }
        
        print("\(examples) for \(word)")
        isLoaded = true
    }
}
