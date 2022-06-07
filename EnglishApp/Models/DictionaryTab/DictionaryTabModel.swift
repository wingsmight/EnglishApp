//
//  DictionaryTabModel.swift
//  EnglishApp
//
//  Created by Igoryok on 21.05.2022.
//

import Foundation

class DictionaryTabModel: ObservableObject {
    @Published public var categories : [LearningCategory] = []
}
