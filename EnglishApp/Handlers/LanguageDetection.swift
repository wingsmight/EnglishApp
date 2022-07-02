//
//  LanguageDetection.swift
//  EnglishApp
//
//  Created by Igoryok on 02.07.2022.
//

import Foundation
import NaturalLanguage

public final class LanguageDetection {
    static func detectLanguageCode(for string: String) -> String? {
        let recognizer = NLLanguageRecognizer()
        recognizer.processString(string)
        guard var languageCode = recognizer.dominantLanguage?.rawValue else { return nil }
        if languageCode == "uk" {
            languageCode = "ru"
        }
        return languageCode
    }
    static func detectLanguage(for string: String) -> Language {
        let languageCode = detectLanguageCode(for: string)
        switch languageCode {
        case "ru", "uk": return .russian
        default: return .english
        }
    }
}
