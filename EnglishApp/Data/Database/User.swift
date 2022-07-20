//
//  User.swift
//  EnglishApp
//
//  Created by Igoryok on 20.07.2022.
//

import Foundation


struct User: Equatable, Codable {
    var email: String
    
    
    internal init() {
        self.email = ""
    }
    internal init(email: String) {
        self.email = email
    }
    
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.email == rhs.email
    }
    static func load() -> User {
        let userData: Data = UserDefaults.standard.data(forKey: "user") ?? Data()
        let decoder = JSONDecoder()
        
        if let storedData = try? decoder.decode(User.self, from: userData) {
            let user = storedData
            
            return user
        }
        
        return User()
    }
    static func save(_ user: User) {
        let encoder = JSONEncoder()
        
        if let storedData = try? encoder.encode(user) {
            let userData = storedData
            
            UserDefaults.standard.set(userData, forKey: "user")
        }
    }
}
