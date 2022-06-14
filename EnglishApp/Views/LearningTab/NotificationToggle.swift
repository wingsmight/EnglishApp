//
//  NotificationToggle.swift
//  EnglishApp
//
//  Created by Igoryok on 14.06.2022.
//

import SwiftUI

struct NotificationToggle: View {
    @Binding public var isEnabled: Bool
    
    @AppStorage("notificationWordCount") private var notificationWordCount: Int = 4
    @EnvironmentObject private var wordPairStore: WordPairStore
    @State private var isPushedWordMaxAlertShowing: Bool = false
    
    
    var body: some View {
        Button {
            print(wordPairStore.pushedWordPairs.count)
            print(notificationWordCount)
            if !isEnabled && wordPairStore.pushedWordPairs.count >= notificationWordCount {
                isPushedWordMaxAlertShowing = true
            } else {
                isEnabled.toggle()
            }
        } label: {
            Image(systemName: isEnabled ? "play.fill" : "play")
                .resizable()
                .scaledToFit()
                .frame(height: 22)
                .padding(.horizontal, 5)
                .foregroundColor(isEnabled ? Color("AppGreen") : .primary)
        }
        .buttonStyle(.plain)
        .alert("Превышено максимальное число слов в уведомлении", isPresented: $isPushedWordMaxAlertShowing) {
            Button("Ок", role: .cancel) { }
        }
    }
}

struct NotificationToggle_Previews: PreviewProvider {
    static var previews: some View {
        NotificationToggle(isEnabled: .constant(true))
    }
}
