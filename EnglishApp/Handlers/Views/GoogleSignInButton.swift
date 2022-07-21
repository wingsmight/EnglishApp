//
//  GoogleSignInButton.swift
//  EnglishApp
//
//  Created by Igoryok on 21.07.2022.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct GoogleSignInButton: View {
    public var action: (GIDGoogleUser?, Error?) -> Void
    
    
    var body: some View {
        Button {
            guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
            
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            GIDSignIn.sharedInstance.signIn(
                with: configuration,
                presenting: presentingViewController,
                callback: action)
        } label: {
            HStack{
                Image("GoogleIcon")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.horizontal)
                
                Text("Войти с помощью Google")
                    .foregroundColor(.black)
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 20)
            .background(.white)
            .background(in: RoundedRectangle(cornerSize: CGSize(width: 15, height: 15)))
            .shadow(radius: 5)
        }
    }
}

struct GoogleSignInButton32_Previews: PreviewProvider {
    static func signIn(for user: GIDGoogleUser?, error: Error?) {
        
    }
    
    
    static var previews: some View {
        GoogleSignInButton(action: signIn)
            .preferredColorScheme(.dark)
    }
}
