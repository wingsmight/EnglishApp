//
//  HtmlRequestError.swift
//  EnglishApp
//
//  Created by Igoryok on 10.05.2022.
//

import Foundation

enum HtmlRequestError: LocalizedError {
    case nonParsableContent

    var errorDescription: String? {
        switch self {
        case .nonParsableContent:
            return "URL content cannot be parsed to HTML"
        }
    }
}
