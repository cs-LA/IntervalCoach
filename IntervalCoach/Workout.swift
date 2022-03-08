//
//  Workout.swift
//

import Foundation
import Combine
import SwiftUI
import AVFoundation
import BackgroundTasks


class Workout: ObservableObject {
  
  init() {
    let intensiveTime = max(UserDefaults.standard.integer(forKey: "intensiveTime"), 1)
    intensiveTimeMinutes = intensiveTime / 60
    intensiveTimeSeconds = intensiveTime % 60
    let relaxedTime = max(UserDefaults.standard.integer(forKey: "relaxedTime"), 1)
    relaxedTimeMinutes = relaxedTime / 60
    relaxedTimeSeconds = relaxedTime % 60
    repetitions = max(UserDefaults.standard.integer(forKey: "repetitions"), 1)
 }
  
  @Published var relaxedTimeMinutes: Int
  @Published var relaxedTimeSeconds: Int
  @Published var intensiveTimeMinutes: Int
  @Published var intensiveTimeSeconds: Int
  @Published var repetitions: Int

  @Published var repCounter = 0
  @Published var isIntensive = false
  @Published var secondsToGo = 0
  @Published var secondsGone = 0
  
  var timer: Cancellable? = nil
  
  let player = try! AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "beep", withExtension: "mp3")!)
  
  
  func start() {
    UserDefaults.standard.set(intensiveTimeMinutes * 60 + intensiveTimeSeconds, forKey: "intensiveTime")
    UserDefaults.standard.set(relaxedTimeMinutes * 60 + relaxedTimeSeconds, forKey: "relaxedTime")
    UserDefaults.standard.set(repetitions, forKey: "repetitions")
    
    let intensiveTime = max(UserDefaults.standard.integer(forKey: "intensiveTime"), 1)
    UserDefaults.standard.set(intensiveTime, forKey: "intensiveTime")
    intensiveTimeMinutes = intensiveTime / 60
    intensiveTimeSeconds = intensiveTime % 60
    let relaxedTime = max(UserDefaults.standard.integer(forKey: "relaxedTime"), 1)
    UserDefaults.standard.set(relaxedTime, forKey: "relaxedTime")
    relaxedTimeMinutes = relaxedTime / 60
    relaxedTimeSeconds = relaxedTime % 60

    repCounter = 0
    isIntensive = false
    secondsToGo = relaxedTime
    secondsGone = 1
    
    UserDefaults.standard.set(Date().timeIntervalSinceReferenceDate, forKey: "workoutStartTime")
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [self] _ in
        update()
      }
    
    var notificationInterval = -1
    for rep in 1...UserDefaults.standard.integer(forKey: "repetitions") {
      notificationInterval += relaxedTime
      scheduleNotification(
        body: String(format: "periodStarted".localized(), rep, "intensivePeriod".localized()),
        interval: notificationInterval
      )

      notificationInterval += intensiveTime
      scheduleNotification(
        body: String(format: "periodStarted".localized(), rep, "relaxedPeriod".localized()),
        interval: notificationInterval
      )
    }
    notificationInterval += relaxedTime
    scheduleNotification(body: "Workout finished", interval: notificationInterval)
  }
  
  
  func update() {
    let intensiveTime = UserDefaults.standard.integer(forKey: "intensiveTime")
    let relaxedTime = UserDefaults.standard.integer(forKey: "relaxedTime")
    let repetitionTime = intensiveTime + relaxedTime
    var secondsElapsed = Int(
      Date().timeIntervalSinceReferenceDate - UserDefaults.standard.double(forKey: "workoutStartTime")
    )
    print(secondsElapsed)
    
    if secondsElapsed < relaxedTime {
      repCounter = 0
      isIntensive = false
      secondsToGo = relaxedTime
      secondsGone = secondsElapsed
    }
    else {
      secondsElapsed = secondsElapsed - relaxedTime
      repCounter = secondsElapsed / repetitionTime + 1
      if repCounter > repetitions {
        player.play()
        stop()
        return
      }
      
      secondsElapsed = secondsElapsed % repetitionTime
      isIntensive = secondsElapsed < intensiveTime
      
      if isIntensive {
        secondsToGo = intensiveTime
        secondsGone = secondsElapsed
      }
      else {
        secondsToGo = relaxedTime
        secondsGone = secondsElapsed - intensiveTime
      }
    }
    
    secondsGone += 1
    print("\(repCounter) - \(secondsGone) - \(isIntensive)")
    if secondsGone == secondsToGo {
      player.play()
      print("beeped")
    }
  }
  
  
  func stop() {
    timer?.cancel()
    timer = nil
    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

    secondsGone = 0
    secondsToGo = 0
    repCounter = 0
  }
  
  
  func scheduleNotification(body: String, interval: Int) {
    let center = UNUserNotificationCenter.current()
    
    let content = UNMutableNotificationContent()
    content.title = "IntervalCoach"
    content.body = body
    content.categoryIdentifier = "alarm"
    //content.sound = UNNotificationSound.default
    content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "beep.mp3"))
    
    var trigger: UNTimeIntervalNotificationTrigger? = nil
    if interval > 0 {
      trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(interval), repeats: false)
    }

    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    center.add(request)
  }

}



extension String {
  func localized() -> String {
    return NSLocalizedString(self, comment: "")
  }
}
