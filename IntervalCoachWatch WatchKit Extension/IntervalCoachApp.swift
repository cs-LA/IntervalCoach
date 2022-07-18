//
//  IntervalCoachApp.swift
//  IntervalCoachWatch WatchKit Extension
//
//  Created by Clemens Schützdeller on 10.06.22.
//

import SwiftUI

@main
struct IntervalCoachApp: App {
  
  let workout = Workout()
  
  var body: some Scene {
    WindowGroup {
      MainScreen(workout: workout)
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
