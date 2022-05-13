//
//  UrlError.swift
//  EnglishApp
//
//  Created by Igoryok on 10.05.2022.
//

import Foundation

enum UrlError: LocalizedError {
    case notValidUrl

    var errorDescription: String? {
        switch self {
        case .notValidUrl:
            return "URL isn't valid"
        }
    }
}
