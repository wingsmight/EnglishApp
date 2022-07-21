//
//  SignOutButton.swift
//  EnglishApp
//
//  Created by Igoryok on 21.07.2022.
//

import SwiftUI
import GoogleSignIn

struct SignOutButton: View {
    @EnvironmentObject private var appAuth: AppAuth
    
    @State private var isSignOutConfirmationShowing = false
    
    
    var body: some View {
        Button {
            isSignOutConfirmationShowing = true
        } label: {
            Text("Выйти")
                .foregroundColor(Color("AppRed"))
        }
        .alert(isPresented: $isSignOutConfirmationShowing) {
            Alert(title: Text("Выйти из аккаунта"), message: Text("Вы уверены?"),
                  primaryButton: .default(Text("Нет"), action: {
                
            }),
                  secondaryButton: .destructive(Text("Да"), action: {
                GIDSignIn.sharedInstance.signOut()
                appAuth.signOut()
            }))
        }
    }
}
