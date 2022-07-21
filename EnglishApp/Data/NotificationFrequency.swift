//
//  NotificationFrequency.swift
//  EnglishApp
//
//  Created by Igoryok on 14.06.2022.
//

import Foundation
import SwiftUI

public enum NotificationFrequency: String, CaseIterable, Equatable {
    case everyHour = "Каждый час"
    case everyDay = "Каждый день"
    
    
    public var description: String {
        return self.rawValue
    }
    public var localizedName: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
    public var seconds: Int {
        switch self {
        case .everyHour:
            return 60 * 60
        case .everyDay:
            return 24 * 60 * 60
        }
    }
}
