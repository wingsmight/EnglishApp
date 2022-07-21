//
//  CloudDatabase.swift
//  AudioRecorder
//
//  Created by Igoryok on 09.10.2021.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import SwiftUI


class CloudDatabase {
    public static func addData(user: User) {
        // Get a reference to the database
        let database = Firestore.firestore()
        
        database.collection("users").addDocument(data: user.dictionaryData) { error in
            if error != nil {
                print(#function, error)
            } else {
                
            }
        }
    }
    public static func getData(email: String, userStore: UserStore) {
        // Get a reference to the database
        let database = Firestore.firestore()
        
        // Read the documents at a specific path
        database.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        let users: [User] = snapshot.documents.map { data in
                            print("user id = \(data.documentID)")
                            
                            return User(from: data)
                        }
                        
                        let user = users[0]
                        userStore.user = user
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
    public static func loadData(user: Firebase.User) {
        let email = user.email
        let database = Firestore.firestore()
        
        // Read the documents at a specific path
        database.collection("users").whereField("email", isEqualTo: email).getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        let user = snapshot.documents.first
                        if let user = user {
                            // TODO
                        }
                    }
                }
            }
            else {
                // Handle the error
            }
        }
    }
}

extension User {
    init(from data: QueryDocumentSnapshot) {
        self.init(email: data["email"] as! String,
                  signUpDate: data["signUpDate"] as! Date,
                  platform: data["platform"] as! String,
                  lastOpeningDate: data["lastOpeningDate"] as! Date,
                  isSubscribed: (data["isSubscribed"] != nil),
                  overallLearnedWordCount: data["overallLearnedWordCount"] as! Int,
                  weeklyLearnedWordCount: data["weeklyLearnedWordCount"] as! Int)
    }
    
    var dictionaryData: [String: Any] {
        ["email": self.email,
         "signUpDate": self.signUpDate,
         "platform": self.platform,
         "lastOpeningDate": self.lastOpeningDate,
         "isSubscribed": self.isSubscribed,
         "overallLearnedWordCount": self.overallLearnedWordCount,
         "weeklyLearnedWordCount": self.weeklyLearnedWordCount]
    }
}
