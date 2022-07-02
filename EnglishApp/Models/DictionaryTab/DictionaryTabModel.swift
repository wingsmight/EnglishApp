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
        @Published public var gainedWordPair: WordPair = WordPair("", "")
        
        
        public func translate() {
            self.outputWord = ""
            self.gainedWordPair = WordPair(self.inputWord, self.outputWord)
            
            TranslationApi.translate(inputWord, to: outputLanguage) { translation in
                DispatchQueue.main.async {
                    self.outputWord = translation
                    self.gainedWordPair = WordPair(self.inputWord, self.outputWord)
                }
            }
        }
    }
}
