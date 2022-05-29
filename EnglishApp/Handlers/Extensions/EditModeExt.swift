//
//  EditModeExt.swift
//  EnglishApp
//
//  Created by Igoryok on 29.05.2022.
//

import SwiftUI

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
