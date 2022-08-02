//
//  Workout.swift
//

import Foundation
import Combine
import SwiftUI


class Workout: ObservableObject {
  
  init() {
    let intensiveTime = max(UserDefaults.standard.integer(forKey: "intensiveTime"), 0)
    intensiveTimeMinutes = Double(intensiveTime / 60)
    intensiveTimeSeconds = Double(intensiveTime % 60)
    let relaxedTime = max(UserDefaults.standard.integer(forKey: "relaxedTime"), 0)
    relaxedTimeMinutes = Double(relaxedTime / 60)
    relaxedTimeSeconds = Double(relaxedTime % 60)
    repetitions = Double(max(UserDefaults.standard.integer(forKey: "repetitions"), 1))
  }
  

  @Published var intensiveTimeMinutes: Double
  @Published var intensiveTimeSeconds: Double
  @Published var relaxedTimeMinutes: Double
  @Published var relaxedTimeSeconds: Double
  @Published var repetitions: Double
  @Published var errorMessage = " \n "
  
  var timer: Cancellable? = nil
  @Published var secondsGone = 0
  var secondsToGo = 0
  var repCounter = 0
  var isIntensive = false
  
  var xRtSession: WKExtendedRuntimeSession? = nil
  
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
    secondsToGo = Int(relaxedTime)
    secondsGone = 1
    
    UserDefaults.standard.set(Date().timeIntervalSinceReferenceDate, forKey: "workoutStartTime")
    timer = Timer
      .publish(every: 1, on: .main, in: .common)
      .autoconnect()
      .sink { [self] _ in
        update()
      }

    xRtSession = WKExtendedRuntimeSession()
    xRtSession?.start()
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
      if repCounter > Int(repetitions) {
        //AudioServicesPlaySystemSound(workoutFinishedSoundID)
        WKInterfaceDevice.current().play(.success)
        //xRtSession.notifyUser(hapticType: .success, repeatHandler: nil)
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
      if secondsGone == secondsToGo / 2 { //AudioServicesPlaySystemSound(intensiveHalfSplitSoundID)
        WKInterfaceDevice.current().play(.retry)
        //xRtSession.notifyUser(hapticType: .retry, repeatHandler: nil)
      }
      if secondsGone == secondsToGo { //AudioServicesPlaySystemSound(stopIntensiveSoundID)
        WKInterfaceDevice.current().play(.stop)
        //xRtSession.notifyUser(hapticType: .stop, repeatHandler: nil)
      }
    }
    else {
      if secondsGone == secondsToGo { //AudioServicesPlaySystemSound(startIntensiveSoundID)
        WKInterfaceDevice.current().play(.start)
        //xRtSession.notifyUser(hapticType: .start, repeatHandler: nil)
      }
    }
  }
  
  
  func stop() {
    xRtSession?.invalidate()
    xRtSession = nil
    timer?.cancel()
    timer = nil
    
    secondsGone = 0
    secondsToGo = 0
    repCounter = 0
  }
  
}
