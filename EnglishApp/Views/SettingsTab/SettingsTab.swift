//
//  SettingsTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct SettingsTab: View {
    var body: some View {
        VStack {
            Text("Настройки")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
            
            DividedVStack(alignment: .leading, spacing: 13) {
                KeyValueView("Ваш часовой пояс", "+3 GMC Новосибирск")
                KeyValueView("Слов в одном уведомлении", "2 ")
                KeyValueView("Частота уведомлений", "Каждый час")
                KeyValueView("Период уведомления", "10:00 – 22:00")
                
                Button {
                    // Action
                } label: {
                    Text("Настройка теста")
                }
                
                Button {
                    // Action
                } label: {
                    Text("Поделиться")
                }
                
                EmptyView()
            }
            .padding()
            
            Button {
                // Action
            } label: {
                Label {
                    Text("Купить подписку")
                        .foregroundColor(Color.white)
                } icon: {
                    Image("Lightning")
                        .foregroundColor(Color.white)
                }
            }
            .buttonStyle(RoundedRectangleButtonStyle(color: .cyan))
            .padding()
            
            Button {
                // Action
            } label: {
                Label {
                    Text("Оплата в условиях ограничений")
                } icon: {
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                }
            }
            .buttonStyle(.borderless)
            .foregroundColor(.primary)
            
            Spacer()
        }
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
