//
//  IntervalCoachApp.swift
//  IntervalCoachWatch WatchKit Extension
//

import SwiftUI


@main
struct IntervalCoachApp: App {
  
  let workout = Workout(backGroundManager: BackgroundManager())
  
  @Environment(\.scenePhase) var scenePhase

  var body: some Scene {
    WindowGroup {
      MainScreen(workout: workout)
    }
    .onChange(of: scenePhase) { newScenePhase in
      switch newScenePhase {
        case .active:
          if workout.timer == nil { print("No workout session active.") }
          else { workout.bgMgr.enableBackgroundProcessing(nil) }
        case .inactive:
          print("App is inactive")
        case .background:
          print("App is in background")
        @unknown default:
          print("Oh - interesting: I received an unexpected new value.")
      }
    }
  }

}
