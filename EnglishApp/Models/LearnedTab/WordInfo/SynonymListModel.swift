//
//  SynonymListModel.swift
//  EnglishApp
//
//  Created by Igoryok on 01.07.2022.
//

import Foundation
import SwiftUI

extension SynonymListView {
    final class SynonymListModel: ObservableObject {
        @Published public var pairLists: [WordPairList] = []
        

        public func getSynonyms(synonymLists: [[String]]) {
            pairLists = synonymLists.map { (synonyms) -> WordPairList in
                var wordPairs: [WordPair] = []
                for synonym in synonyms {
                    wordPairs.append(WordPair(synonym, ""))
                }
                
                return WordPairList(wordPairs: wordPairs)
            }
            
            for pairListIndex in 0..<pairLists.count {
                for wordPairIndex in 0..<pairLists[pairListIndex].wordPairs.count {
                    TranslationApi.translate(pairLists[pairListIndex].wordPairs[wordPairIndex].Original, to: .russian) { translatedSynonym in
                        DispatchQueue.main.async {
                            self.pairLists[pairListIndex].wordPairs[wordPairIndex].Translation = translatedSynonym
                        }
                    }
                }
            }
        }
    }
}
