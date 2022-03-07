//
//  IntervalCoachApp.swift
//

import SwiftUI
import AVFoundation


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

  @Environment(\.scenePhase) private var scenePhase

  let workout = Workout()
  
  var body: some Scene {
    WindowGroup {
      MainScreen(workout: workout)
    }
    .onChange(of: scenePhase) { phase in
      switch phase {
          // The Active state is used when your app is in the foreground and interactive for the user,
          // meaning that they are using it right now.
        case .active: do {
          do {
          // see https://developer.apple.com/documentation/avfoundation/avaudiosessioncategoryplayback
          // and https://developer.apple.com/documentation/avfoundation/avaudiosessionmodemovieplayback
            try AVAudioSession.sharedInstance()
              .setCategory(
                .playback,
                //mode: .moviePlayback,
                options: .duckOthers
              )
            print("AVAudioSession category set")
          }
          catch {
            print("Error setting AVAudioSession category:\n\(error)\nBecause of this, there may be no sound.")
          }
        }
          
          // The Inactive state is used when your app is visible, but not directly interactive to the user.
          // For example, if you enter multi-tasking mode while running the app,
          // you can see your app’s window alongside others, but you’re not directly using it.
        case .inactive: do {
        }
          
          //  The Background state is used when your app isn’t currently visible,
          // so you should cut back the amount of work you do.
        case .background: do {
        }
          
        @unknown default: do { print("What's that ???") }
      }
    }

  }
  
}
