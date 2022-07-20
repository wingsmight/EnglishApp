//
//  SignUpView.swift
//  AudioRecorder
//
//  Created by Igoryok on 07.10.2021.
//

import SwiftUI
import FirebaseFirestore

struct SignUpView: View {
    @StateObject private var model = ViewModel()
    
    @State private var errorMessage = ""
    @State private var backgroundColor: Color = Color(UIColor.systemBackground)

    @EnvironmentObject private var appAuth: AppAuth
    
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(showsIndicators: false) {
                Spacer()
                
                TextFieldView(label: "Эл. почта", text: $model.email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                
                SecureField(
                    "Пароль",
                    text: $model.password
                ) {
                    
                }
                .font(.title3)
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(5.0)
                .padding(.vertical, 8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textContentType(.newPassword)
                
                SecureField(
                    "Подтвердите пароль",
                    text: $model.repeatedPassword
                ) {
                    
                }
                .font(.title3)
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(5.0)
                .padding(.vertical, 8)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .textContentType(.newPassword)
                
                Text(errorMessage)
                    .foregroundColor(Color("AuthAlert"))
                    .padding(.top, 3)
                    .frame(height: 50, alignment: .top)
                    .minimumScaleFactor(0.5)
                
                Button {
                    if model.password != model.repeatedPassword {
                        errorMessage = "Пароли не совпадают!"
                        alertBackground()
                        return
                    }
                    
                    appAuth.signUp(
                        email: model.email,
                        password: model.password,
                        handleError: {error in
                            errorMessage = AppAuth.localizeAuthError(error)
                        
                            alertBackground()
                        },
                        handleSuccess: {
                            let user = User(email: model.email)
                            
                            CloudDatabase.addData(user: user)
                            User.save(user)
                        })
                } label: {
                    Text("Войти")
                        .bold()
                        .font(.title3)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 210, height: 55)
                        .background(Color("AppGreen"))
                        .cornerRadius(15.0)
                }
                .padding(.top, 12)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Регистрация")
            .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
        }
    }
    
    private func alertBackground() {
        withAnimation(.easeInOut(duration: 0.5)) {
            self.backgroundColor = Color("AuthAlert")
            
            withAnimation(.easeInOut(duration: 1)) {
                self.backgroundColor = Color(UIColor.systemBackground)
            }
        }
    }
}

struct TextFieldView: View {
    public var label: String
    @Binding public var text: String
    
    
    var body: some View {
        TextField(
            label,
            text: $text
        )
            .font(.title3)
            .padding()
            .background(Color(UIColor.systemGray5))
            .cornerRadius(5.0)
            .padding(.vertical, 8)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

