//
//  LocalNotificationManager.swift
//  EnglishApp
//
//  Created by Igoryok on 22.05.2022.
//

import Foundation
import SwiftUI

class LocalNotificationManager: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published public var pushedWordPairs: [WordPair] = []
    
    @AppStorage("notificationFrequency") private var notificationFrequency: NotificationFrequency = .everyHour
    @AppStorage("notificationStartTime") private var notificationStartTime = Calendar.current.date(bySettingHour: 8, minute: 0, second: 0, of: Date())!
    @AppStorage("notificationFinishTime") private var notificationFinishTime = Calendar.current.date(bySettingHour: 20, minute: 0, second: 0, of: Date())!
    private let center = UNUserNotificationCenter.current()
    private let repeatWordsIdentifier: String = "repeatWords"
    //private var repeatWordsIdentifiers: [String] = []
    
    
    public override init() {
        super.init()
        
        center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications permitted")
            } else {
                print("Notifications not permitted")
            }
        }
    }
    
    
    public func askUserPermission(completionHandler: @escaping (Bool, Error?) -> Void) {
        self.center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: completionHandler)
    }
    public func repeatPushedWordPairs() {
        if pushedWordPairs.count <= 0 {
            return
        }
        
        cancelRepeatWordsNotifications()
        //repeatWordsIdentifiers = []
        
        var frequency: NotificationFrequency = .everyHour
        if let rawFrequency = UserDefaults.standard.string(forKey: "notificationFrequency") {
            frequency = NotificationFrequency(rawValue: rawFrequency) ?? .everyHour
        }
        let timeInterval: TimeInterval = TimeInterval(frequency.seconds)
        
        var notificationDate: Date = notificationStartTime
        sendRepeatWordsNotification(at: notificationDate)
        
        while notificationDate.addingTimeInterval(timeInterval) < notificationFinishTime {
            notificationDate.addTimeInterval(timeInterval)
            
            sendRepeatWordsNotification(at: notificationDate)
        }
    }
    
    private func cancelRepeatWordsNotifications() {
        center.removePendingNotificationRequests(withIdentifiers: [repeatWordsIdentifier])
    }
    
    private func sendRepeatWordsNotification(at date: Date) {
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
        
        let content = UNMutableNotificationContent()
        content.body = "Повторите слова"
        content.interruptionLevel = .timeSensitive
        
        var subtitle = pushedWordPairs[0].Original + " - " + pushedWordPairs[0].Translation
        for pushedWord in pushedWordPairs.dropFirst() {
            subtitle += ", " + pushedWord.Original + " - " + pushedWord.Translation
        }
        content.subtitle = subtitle
        
        let identifier = repeatWordsIdentifier// + date.getTimeString()
        //repeatWordsIdentifiers.append(identifier)
        content.categoryIdentifier = "category" + repeatWordsIdentifier
        content.sound = UNNotificationSound.default
        content.userInfo = ["wordPairs" : pushedWordPairs[0].Original]
        
        let taskIdentifier = identifier
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: taskIdentifier, content: content, trigger: trigger)
        
        self.center.delegate = self
        
        let markAsCompleted = UNNotificationAction(identifier: Action.markAsLearned.description, title: Action.markAsLearned.title)
        let dontSendToday = UNNotificationAction(identifier: Action.dontSendToday.description, title: Action.dontSendToday.title)
        
        let category = UNNotificationCategory(identifier: identifier/* + date.getTimeString()*/, actions: [markAsCompleted, dontSendToday], intentIdentifiers: []) // // Same Identifier in schedulNotification()
        
        self.center.setNotificationCategories([category])
        
        self.center.add(request) { (error : Error?) in
            if error != nil {
                // TODO: Handle any errors
            }
        }
    }
    
    internal func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo

        if let _ = userInfo["wordPairs"] as? String {
                switch response.actionIdentifier {
                case UNNotificationDefaultActionIdentifier:
                    // the user swiped to unlock
                    print("Default identifier")
                    break

                case Action.markAsLearned.description:
                    for var pushedWordPair in pushedWordPairs {
                        pushedWordPair.IsPushed = false
                        pushedWordPair.State = .learned
                    }
                    
                    LocalNotificationManager.pushedWordsData = try? JSONEncoder().encode(pushedWordPairs)
                    
                    cancelRepeatWordsNotifications()
                    break
                    
                case Action.dontSendToday.description:
                    cancelRepeatWordsNotifications()
                    break
                    
                default:
                    break
                }
            }
        
        completionHandler()
    }
    
    
    public static var pushedWordsData: Data? = nil
    
    
    private enum Action: String {
        case markAsLearned = "MARK_AS_LEARNED"
        case dontSendToday = "DONT_SEND_TODAY"
        
        
        var description: String {
            return self.rawValue
        }
        var localizedName: LocalizedStringKey {
            LocalizedStringKey(rawValue)
        }
        var title: String {
            switch(self) {
            case .markAsLearned:
                return "Выучено"
            case .dontSendToday:
                return "Не присылать сегодня"
            }
        }
    }
}
