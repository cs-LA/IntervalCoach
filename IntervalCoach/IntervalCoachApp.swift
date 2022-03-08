//
//  IntervalCoachApp.swift
//

import SwiftUI
import AVFoundation
import BackgroundTasks

/*
 A simple, easy to use Interval Timer.
 
 It allows you to control all your HIIT and Tabata workouts by just setting
 the length of an intensive and a relaxed time interval.
 Combined with the number of interval repetitions you can start your training.
 
 The training will always start with an relaxed period to give you the chance to prepare yourself.
 
 ------------
 
 Ein einfacher, benutzerfreundlicher Intervall-Timer.
 
 Kontrolliere alle Deine HIIT- und Tabata-Trainingseinheiten ganz einfach durch Festlegung
 der Länge eines intensiven und eines entspannten Zeitintervalls.
 Kombiniert mit der Anzahl der Intervallwiederholungen kann das Training losgehen.
 
 Das Training beginnt immer mit einer entspannten Phase, um sich vorbereiten zu können.
 */

@main
struct IntervalCoachApp: App {

  let workout = Workout()
  
  init() {
    do {
      // see https://developer.apple.com/documentation/avfoundation/avaudiosessioncategoryplayback
      // and https://developer.apple.com/documentation/avfoundation/avaudiosessionmodemovieplayback
      try AVAudioSession.sharedInstance()
        .setCategory(.playback, options: .duckOthers)
      print("AVAudioSession-Category set")
    }
    catch {
      print("Error setting AVAudioSession-Category:\n\(error)\nBecause of this, there may be no sound.")
    }
    
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.alert, .badge ,.sound]) { success, error in
        if success { print("Notification-Authorization granted") }
        else { print("Notification-Authorization denied") }
        
        if let error = error {
          print("Error requesting Notification-Authorization:\n\(error)\nBecause of this, background processing will not work.")
        }
      }
  }
  
  
  var body: some Scene {
    WindowGroup {
      MainScreen(workout: workout)
    }
  }
  
}
