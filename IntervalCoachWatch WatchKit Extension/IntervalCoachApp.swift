//
//  IntervalCoachApp.swift
//  IntervalCoachWatch WatchKit Extension
//

import SwiftUI


@main
struct IntervalCoachApp: App {
  
  let workout = Workout()
  @Environment(\.scenePhase) var scenePhase

  var body: some Scene {
    WindowGroup {
      MainScreen(workout: workout)
    }
    .onChange(of: scenePhase) { newScenePhase in
      switch newScenePhase {
        case .active:
          if workout.timer == nil { print("No workout session active.") }
          else {
            print(workout.xRtSession?.expirationDate as Any)
            workout.xRtSession?.invalidate()
            workout.xRtSession = WKExtendedRuntimeSession()
            workout.xRtSession?.start()
          }
        case .inactive:
          print("App is inactive")
        case .background:
          print("App is in background")
        @unknown default:
          print("Oh - interesting: I received an unexpected new value.")
      }
    }
  }

//    @SceneBuilder var body: some Scene {
//        WindowGroup {
//            NavigationView {
//                ContentView()
//            }
//        }

//        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
//    }
}
