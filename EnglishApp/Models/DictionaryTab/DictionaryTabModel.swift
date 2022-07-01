//
//  DictionaryTabModel.swift
//  EnglishApp
//
//  Created by Igoryok on 21.05.2022.
//

import Foundation

extension DictionaryTab {
    final class DictionaryTabModel: ObservableObject {
        @Published public var categories : [LearningCategory] = []
        @Published public var inputWord: String = ""
        @Published public var outputWord: String = ""
        @Published public var inputLanguage: Language = .english
        @Published public var outputLanguage: Language = .russian
        @Published public var translatedWord: String? = nil
        @Published public var gainedWordPair: WordPair? = nil
        
        
        public func translate() {
            TranslationApi.translate(inputWord, to: outputLanguage) { translation in
                DispatchQueue.main.async {
                    self.outputWord = translation
                }
            }
        }
    }
}
