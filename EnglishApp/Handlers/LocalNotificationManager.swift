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
    
    private let center = UNUserNotificationCenter.current()
    
    
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
            
        let content = UNMutableNotificationContent()
        content.interruptionLevel = .timeSensitive
        
        var subtitle = pushedWordPairs[0].original + " - " + pushedWordPairs[0].translation
        for pushedWord in pushedWordPairs.dropFirst() {
            subtitle += ", " + pushedWord.original + " - " + pushedWord.translation
        }
        content.subtitle = subtitle
        
        let identifier = pushedWordPairs[0].original + pushedWordPairs[0].translation
        content.categoryIdentifier = identifier
        content.sound = UNNotificationSound.default
        content.userInfo = ["wordPairs" : pushedWordPairs[0].original]
        
        let taskIdentifier = identifier
        
        let timeInterval: TimeInterval = 60 * 60
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: true)
        let request = UNNotificationRequest(identifier: taskIdentifier, content: content, trigger: trigger)
        
        self.center.delegate = self
        
        let markAsCompleted = UNNotificationAction(identifier: Action.markAsLearned.description, title: "Выучено")
        let dontSendToday = UNNotificationAction(identifier: Action.dontSendToday.description, title: "Не присылать сегодня")
        
        let placeholder = "Task"
        let category = UNNotificationCategory(identifier: identifier, actions: [markAsCompleted, dontSendToday], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: placeholder) // // Same Identifier in schedulNotification()
        
        self.center.setNotificationCategories([category])
        
        self.center.add(request) { (error : Error?) in
            if let error = error {
                // Handle any errors
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
                        pushedWordPair.isPushed = false
                        pushedWordPair.state = .learned
                    }
                    
                    LocalNotificationManager.pushedWordsData = try? JSONEncoder().encode(pushedWordPairs)
                    
                    center.removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
                    break
                    
                case Action.dontSendToday.description:
                    center.removePendingNotificationRequests(withIdentifiers: [response.notification.request.identifier])
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
    }
}
