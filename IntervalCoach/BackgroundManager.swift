//
//  BackgroundManager.swift (iOS)
//

import Foundation
import SwiftUI


struct BackgroundManager: BackgroundManagerProtocol {
  
  func enableBackgroundProcessing(_ workout: Workout? = nil) { print("iOS-BgMgr")
    guard let workout = workout else { return }
    var notificationTimeOffset = -1
    for rep in 1...UserDefaults.standard.integer(forKey: "repetitions") {
      notificationTimeOffset += workout.relaxedTime
      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodStarted", comment: ""), rep),
        sound: "whistleStartIntensive.mp3",
        secondsFromNow: notificationTimeOffset
      )
      
      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodHalfTime", comment: ""), rep),
        sound: "intensiveHalfSplit.mp3",
        secondsFromNow: notificationTimeOffset + workout.intensiveTime / 2
      )
      
      notificationTimeOffset += workout.intensiveTime
      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodEnded", comment: ""), rep),
        sound: "whistleStopIntensive.mp3",
        secondsFromNow: notificationTimeOffset
      )
    }
    notificationTimeOffset += workout.relaxedTime
    scheduleBackgroundNotification(
      body: String(format: NSLocalizedString("workoutFinished", comment: "")),
      sound: "whistleWorkoutFinished.mp3",
      secondsFromNow: notificationTimeOffset
    )
  }
  
  func disableBackgroundProcessing() { print("iOS-BgMgr")
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
  }
 
  
  func scheduleBackgroundNotification(body: String, sound: String, secondsFromNow: Int) {
    let content = UNMutableNotificationContent()
    content.title = "IntervalCoach"
    content.categoryIdentifier = "alarm"
    content.body = body
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: sound))
    
    var trigger: UNTimeIntervalNotificationTrigger? = nil
    if secondsFromNow > 0 {
      trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(secondsFromNow), repeats: false)
    }
    
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
  }

}
