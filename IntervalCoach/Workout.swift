//
//  Workout.swift
//

import Foundation
import Combine
import SwiftUI
import AVFoundation


class Workout: ObservableObject {
  
  init() {
    let intensiveTime = max(UserDefaults.standard.integer(forKey: "intensiveTime"), 0)
    intensiveTimeMinutes = intensiveTime / 60
    intensiveTimeSeconds = intensiveTime % 60
    let relaxedTime = max(UserDefaults.standard.integer(forKey: "relaxedTime"), 0)
    relaxedTimeMinutes = relaxedTime / 60
    relaxedTimeSeconds = relaxedTime % 60
    repetitions = max(UserDefaults.standard.integer(forKey: "repetitions"), 1)

    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/01-whistle-captians.mp3
    let startIntensiveURL = Bundle.main.url(forResource: "whistleStartIntensive", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(startIntensiveURL! as CFURL, &startIntensiveSoundID)
    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/02-whistle-kick.mp3
    let stopIntensiveURL = Bundle.main.url(forResource: "whistleStopIntensive", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(stopIntensiveURL! as CFURL, &stopIntensiveSoundID)
    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/08-whistle-end-of-game.mp3
    let workoutFinishedURL = Bundle.main.url(forResource: "whistleWorkoutFinished", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(workoutFinishedURL! as CFURL, &workoutFinishedSoundID)
    // https://klingeltonmobi.de/download/?id=3568
    let intensiveHalfSplitURL = Bundle.main.url(forResource: "intensiveHalfSplit", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(intensiveHalfSplitURL! as CFURL, &intensiveHalfSplitSoundID)

  }
  
  var startIntensiveSoundID = SystemSoundID(101)
  var stopIntensiveSoundID = SystemSoundID(102)
  var intensiveHalfSplitSoundID = SystemSoundID(105)
  var workoutFinishedSoundID = SystemSoundID(109)

  @Published var intensiveTimeMinutes: Int
  @Published var intensiveTimeSeconds: Int
  @Published var relaxedTimeMinutes: Int
  @Published var relaxedTimeSeconds: Int
  @Published var repetitions: Int
  @Published var errorMessage = " \n "

  var timer: Cancellable? = nil
  @Published var secondsGone = 0
  var secondsToGo = 0
  var repCounter = 0
  var isIntensive = false

  
  func start() {
    errorMessage = " \n "
    let intensiveTime = intensiveTimeMinutes * 60 + intensiveTimeSeconds
    let relaxedTime = relaxedTimeMinutes * 60 + relaxedTimeSeconds
    guard intensiveTime + relaxedTime > 0 else {
      errorMessage = NSLocalizedString("zeroTimeMsg", comment: "")
      return
    }
    
    UserDefaults.standard.set(intensiveTime, forKey: "intensiveTime")
    UserDefaults.standard.set(relaxedTime, forKey: "relaxedTime")
    UserDefaults.standard.set(repetitions, forKey: "repetitions")
    
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
    
    var notificationTimeOffset = -1
    for rep in 1...UserDefaults.standard.integer(forKey: "repetitions") {
      notificationTimeOffset += relaxedTime
      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodStarted", comment: ""), rep),
        sound: "whistleStartIntensive.mp3",
        secondsFromNow: notificationTimeOffset
      )

      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodHalfTime", comment: ""), rep),
        sound: "intensiveHalfSplit.mp3",
        secondsFromNow: notificationTimeOffset + intensiveTime / 2
      )
      
      notificationTimeOffset += intensiveTime
      scheduleBackgroundNotification(
        body: String(format: NSLocalizedString("intensivePeriodEnded", comment: ""), rep),
        sound: "whistleStopIntensive.mp3",
        secondsFromNow: notificationTimeOffset
      )
    }
    notificationTimeOffset += relaxedTime
    scheduleBackgroundNotification(
      body: String(format: NSLocalizedString("workoutFinished", comment: "")),
      sound: "whistleWorkoutFinished.mp3",
      secondsFromNow: notificationTimeOffset
    )
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
        AudioServicesPlaySystemSound(workoutFinishedSoundID)
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
//    if secondsGone == secondsToGo {
//      isIntensive
//      ? AudioServicesPlaySystemSound(stopIntensiveSoundID)
//      : AudioServicesPlaySystemSound(startIntensiveSoundID)
//      print("whistled")
//    }
    
    if isIntensive {
      if secondsGone == secondsToGo / 2 { AudioServicesPlaySystemSound(intensiveHalfSplitSoundID) }
      if secondsGone == secondsToGo { AudioServicesPlaySystemSound(stopIntensiveSoundID) }
    }
    else {
      if secondsGone == secondsToGo { AudioServicesPlaySystemSound(startIntensiveSoundID) }
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
