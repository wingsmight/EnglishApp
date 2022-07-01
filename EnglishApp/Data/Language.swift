//
//  Language.swift
//  EnglishApp
//
//  Created by Igoryok on 13.05.2022.
//

import Foundation
import SwiftUI

enum Language: String, CaseIterable, Equatable {
    case english = "Английский"
    case russian = "Русский"
    
    
    var description: String {
        return self.rawValue
    }
    var localizedName: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
    var short: String {
        switch self {
        case .english: return "en"
        case .russian: return "ru"
        }
    }
}
