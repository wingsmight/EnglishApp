//
//  User.swift
//  EnglishApp
//
//  Created by Igoryok on 20.07.2022.
//

import Foundation
import UIKit


struct User: Equatable, Codable {
    var email: String
    var signUpDate: Date
    var platform: String
    var lastOpeningDate: Date
    var isSubscribed: Bool
    var overallLearnedWordCount: Int
    var weeklyLearnedWordCount: Int
    
    
    internal init() {
        self.init(email: "",
                  signUpDate: Date.now,
                  platform: UIDevice.current.systemName,
                  lastOpeningDate: Date.now,
                  isSubscribed: false,
                  overallLearnedWordCount: 0,
                  weeklyLearnedWordCount: 0)
    }
    internal init(email: String,
                  signUpDate: Date,
                  platform: String,
                  lastOpeningDate: Date,
                  isSubscribed: Bool,
                  overallLearnedWordCount: Int,
                  weeklyLearnedWordCount: Int) {
        self.email = email
        self.signUpDate = signUpDate
        self.platform = platform
        self.lastOpeningDate = lastOpeningDate
        self.isSubscribed = isSubscribed
        self.overallLearnedWordCount = overallLearnedWordCount
        self.weeklyLearnedWordCount = weeklyLearnedWordCount
    }
    
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }
//    static func load() -> User {
//        let userData: Data = UserDefaults.standard.data(forKey: "user") ?? Data()
//        let decoder = JSONDecoder()
//
//        if let storedData = try? decoder.decode(User.self, from: userData) {
//            let user = storedData
//
//            return user
//        }
//
//        return User()
//    }
//    static func save(_ user: User) {
//        let encoder = JSONEncoder()
//
//        if let storedData = try? encoder.encode(user) {
//            let userData = storedData
//
//            UserDefaults.standard.set(userData, forKey: "user")
//        }
//    }
    
    public static func createNewUser(email: String) -> User {
        User(email: email,
             signUpDate: Date.now,
             platform: UIDevice.current.systemName,
             lastOpeningDate: Date.now,
             isSubscribed: false,
             overallLearnedWordCount: 0,
             weeklyLearnedWordCount: 0)
    }
}
