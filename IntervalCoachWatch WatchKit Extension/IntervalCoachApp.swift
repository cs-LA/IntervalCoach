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
          if workout.timer != nil { workout.bgMgr.enableBackgroundProcessing(nil) }
        case .inactive:
          break
        case .background:
          break
        @unknown default:
          print("Oh - interesting: I received an unexpected new value.")
      }
    }
  }

}
