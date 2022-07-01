//
//  ExampleListModel.swift
//  EnglishApp
//
//  Created by Igoryok on 01.07.2022.
//

import Foundation
import SwiftUI

extension ExampleListView {
    final class ExampleListModel: ObservableObject {
        @Published public var examplePairs = [WordPair]()
        

        public func getExamplePairs(_ examples: [String]) {
            self.examplePairs = []
            for exampleIndex in 0..<examples.count {
                let example = examples[exampleIndex]
                examplePairs.append(WordPair(example, ""))
                TranslationApi.translate(example, to: .russian) { translation in
                    DispatchQueue.main.async {
                        self.examplePairs[exampleIndex].Translation = translation
                    }
                }
            }
        }
    }
}
