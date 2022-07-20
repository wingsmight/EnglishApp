//
//  LogInModel.swift
//  EnglishApp
//
//  Created by Igoryok on 03.07.2022.
//

import Foundation

extension LogInView {
    @MainActor class ViewModel: ObservableObject {
        @Published public var email: String = ""
        @Published public var password: String = ""
        @Published public var repeatedPassword: String = ""
    }
}
