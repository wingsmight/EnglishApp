//
//  IExamplesApi.swift
//  EnglishApp
//
//  Created by Igoryok on 02.07.2022.
//

import Foundation

public protocol IExamplesApi {
    var examples: [String] { get }
    var isLoaded: Bool { get }
    
    
    func loadExamples(word: String) async
}
