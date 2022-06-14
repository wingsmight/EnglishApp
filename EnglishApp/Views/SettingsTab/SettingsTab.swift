//
//  SettingsTab.swift
//  EnglishApp
//
//  Created by Igoryok on 04.05.2022.
//

import SwiftUI

struct SettingsTab: View {
    private let minNotificationWordCount = 2
    private let maxNotificationWordCount = 10
    
    
    @AppStorage("notificationWordCount") private var notificationWordCount: Int = 4
    @AppStorage("notificationFrequency") private var notificationFrequency: NotificationFrequency = .everyHour
    @AppStorage("notificationStartTime") private var notificationStartTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @AppStorage("notificationFinishTime") private var notificationFinishTime = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    
    @State private var selectedNotificationWordCountIndex = 0
    @State private var isNotificationPeriodShowing = false
    
    
    var body: some View {
        VStack {
            DividedVStack(alignment: .leading, spacing: 13) {
                KeyValueText("Ваш часовой пояс", timeZoneLabel)
                
                KeyValueView(Text("Слов в одном уведомлении")) {
                    Picker("Слов в одном уведомлении", selection: $selectedNotificationWordCountIndex) {
                        ForEach(minNotificationWordCount..<(maxNotificationWordCount + 1)) {
                            Text("\($0)")
                        }
                    }
                    .onChanged(of: selectedNotificationWordCountIndex) { newIndex in
                        notificationWordCount = minNotificationWordCount + newIndex
                        print("notificationWordCount = \(notificationWordCount)")
                    }
                }

                
                KeyValueView(Text("Частота уведомлений")) {
                    Picker("Частота уведомлений", selection: $notificationFrequency) {
                        ForEach(NotificationFrequency.allCases, id: \.self) { value in
                            Text(value.localizedName)
                        }
                    }
                }
                
                KeyValueView(Text("Период уведомления")) {
                    Button {
                        isNotificationPeriodShowing = true
                    } label: {
                        Text("\(notificationStartTime.getTimeString()) - \(notificationFinishTime.getTimeString())")
                    }
                }
                
                Button {
                    // TODO: Action
                } label: {
                    Text("Настройка теста")
                }
                
                Button {
                    // TODO: Action
                } label: {
                    Text("Поделиться")
                }
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
        .navigationTitle("Настройки")
        .sheet(isPresented: $isNotificationPeriodShowing) {
            TimeIntervalPickerView(startTime: $notificationStartTime, finishTime: $notificationFinishTime, isShowing: $isNotificationPeriodShowing)
         }
        .onAppear() {
            selectedNotificationWordCountIndex = notificationWordCount - minNotificationWordCount
        }
    }
    
    
    private var timeZoneLabel: String {
        TimeZone.current.localizedName(for: .shortStandard, locale: Locale.current) ?? ""
    }
    
    
    var customLabel: some View {
        HStack {
            Image(systemName: "paperplane")
            Text(String(1))
            Spacer()
            Text("⌵")
                .offset(y: -4)
        }
        .foregroundColor(.white)
        .font(.title)
        .padding()
        .frame(height: 32)
        .background(Color.blue)
        .cornerRadius(16)
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
