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
                
                TestSettingsButton()
                
                Button {
                    shareApp()
                } label: {
                    Text("Поделиться")
                }
            }
            .padding()
            
            Button {
                // TODO: Action
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
                // TODO: Action
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
    
    
    struct TestSettingsButton: View {
        var body: some View {
            NavigationLink(destination: TestSettingsTab()) {
                Text("Настройка теста")
            }
        }
    }
    
    
    private func shareApp() {
        guard let urlShare = URL(string: "https://www.apple.com/app-store/") else { return }
        let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
        
        if #available(iOS 15.0, *) {
            UIApplication.shared.keyWindow?.rootViewController?.present(activityVC, animated: true, completion: nil)
        } else {
            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
    
    
    private var timeZoneLabel: String {
        TimeZone.current.localizedName(for: .shortStandard, locale: Locale.current) ?? ""
    }
}

struct SettingsTab_Previews: PreviewProvider {
    static var previews: some View {
        SettingsTab()
    }
}
