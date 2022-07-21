//
//  LogInModel.swift
//  EnglishApp
//
//  Created by Igoryok on 03.07.2022.
//

import Foundation
import GoogleSignIn
import Firebase

extension LogInView {
    @MainActor class ViewModel: ObservableObject {
        @Published public var email: String = ""
        @Published public var password: String = ""
        @Published public var repeatedPassword: String = ""
        
        
        public func logIn(){
            
        }
        public func logInViaGoogle(for user: GIDGoogleUser?, with error: Error?) {
            if let error = error {
                print("error: \(error.localizedDescription)")
            }
            else if let user = user {
                let authentication = user.authentication
                guard let idToken = authentication.idToken else { return }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
                
                Auth.auth().signIn(with: credential) { (result, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let profile = user.profile {
                        let user = User(email: profile.email)
                        
                        CloudDatabase.addData(user: user)
                        User.save(user)
                    }
                }
            }
        }
    }
}
