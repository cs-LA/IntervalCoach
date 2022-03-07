//
//  Workout.swift
//

import Foundation
import Combine
import SwiftUI
import AVFoundation


class Workout: ObservableObject {
  
  init() {
    intensiveTimeMinutes = UserDefaults.standard.integer(forKey: "intensiveTime") / 60
    intensiveTimeSeconds = UserDefaults.standard.integer(forKey: "intensiveTime") % 60
    relaxedTimeMinutes = UserDefaults.standard.integer(forKey: "relaxedTime") / 60
    relaxedTimeSeconds = UserDefaults.standard.integer(forKey: "relaxedTime") % 60
    repetitions = UserDefaults.standard.integer(forKey: "repetitions")
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
    
    intensiveTimeMinutes = UserDefaults.standard.integer(forKey: "intensiveTime") / 60
    intensiveTimeSeconds = UserDefaults.standard.integer(forKey: "intensiveTime") % 60
    relaxedTimeMinutes = UserDefaults.standard.integer(forKey: "relaxedTime") / 60
    relaxedTimeSeconds = UserDefaults.standard.integer(forKey: "relaxedTime") % 60

    repCounter = 0
    isIntensive = false
    secondsToGo = UserDefaults.standard.integer(forKey: "relaxedTime")
    secondsGone = 1
    
    UserDefaults.standard.set(Date().timeIntervalSinceReferenceDate, forKey: "workoutStartTime")
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [self] _ in
        update()
      }
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
    if secondsGone == secondsToGo { player.play(); print("beeped") }
  }
  
  func stop() {
    timer?.cancel()
    timer = nil
    secondsGone = 0
    secondsToGo = 0
    repCounter = 0
  }
  
}
