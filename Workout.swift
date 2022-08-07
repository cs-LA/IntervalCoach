//
//  Workout.swift
//

import Foundation
import Combine
import SwiftUI


class Workout: ObservableObject {
  
  let bgMgr: BackgroundManagerProtocol
  
  init(backGroundManager: BackgroundManagerProtocol) {
    let intensiveTime = max(UserDefaults.standard.integer(forKey: "intensiveTime"), 0)
    intensiveTimeMinutes = intensiveTime / 60
    intensiveTimeSeconds = intensiveTime % 60
    let relaxedTime = max(UserDefaults.standard.integer(forKey: "relaxedTime"), 0)
    relaxedTimeMinutes = relaxedTime / 60
    relaxedTimeSeconds = relaxedTime % 60
    repetitions = max(UserDefaults.standard.integer(forKey: "repetitions"), 1)
    
    bgMgr = backGroundManager
  }
  

  @Published var intensiveTimeMinutes: Int
  @Published var intensiveTimeSeconds: Int
  @Published var relaxedTimeMinutes: Int
  @Published var relaxedTimeSeconds: Int
  @Published var repetitions: Int

  
  var timer: Cancellable? = nil
  @Published var secondsGone = 0
  var secondsToGo = 0
  var repCounter = 0
  var isIntensive = false

  var intensiveTime = 0
  var relaxedTime = 0

  
  func start() {
    intensiveTime = intensiveTimeMinutes * 60 + intensiveTimeSeconds
    relaxedTime = relaxedTimeMinutes * 60 + relaxedTimeSeconds
    guard intensiveTime + relaxedTime > 0 else {
      AlarmManager.play(AlarmFinished())
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
    
    bgMgr.enableBackgroundProcessing(self)
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
      if repCounter > repetitions { // Emergency Exit in case we missed the secondsGone == secondsToGo moment !
        AlarmManager.play(AlarmFinished())
        stop()
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
    
    if isIntensive {
      if secondsGone == secondsToGo / 2 {
        AlarmManager.play(AlarmHalfSplit())
      }
      if secondsGone == secondsToGo {
        AlarmManager.play(AlarmStop())
      }
    }
    else {
      if secondsGone == secondsToGo {
        if repCounter < repetitions {
          AlarmManager.play(AlarmStart())
        }
        else {
          AlarmManager.play(AlarmFinished())
          stop()
        }
      }
    }
  }
  
  
  func stop() {
    bgMgr.disableBackgroundProcessing()
    timer?.cancel()
    timer = nil
    
    secondsGone = 0
    secondsToGo = 0
    repCounter = 0
  }

}
