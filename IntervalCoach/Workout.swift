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
    secondsToGo = isIntensive
    ? UserDefaults.standard.integer(forKey: "intensiveTime")
    : UserDefaults.standard.integer(forKey: "relaxedTime")

    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [self] _ in
        secondsGone += 1
        
        if secondsGone == secondsToGo {
          player.play()
        }
        
        if secondsGone > secondsToGo {
          isIntensive.toggle()
          secondsToGo = isIntensive
          ? UserDefaults.standard.integer(forKey: "intensiveTime")
          : UserDefaults.standard.integer(forKey: "relaxedTime")
          secondsGone = 0
          
          if isIntensive {
            repCounter += 1
            if repCounter > repetitions {
              stop()
            }
          }
        }
      }
  }
  
  func stop() {
    timer?.cancel()
    timer = nil
    secondsGone = 0
    secondsToGo = 0
    repCounter = 0
  }
  
}
