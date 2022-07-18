//
//  MainScreen.swift
//

import Foundation
import SwiftUI


struct MainScreen: View {
  
  @ObservedObject var workout: Workout
  
  init(workout: Workout) {
    self.workout = workout
  }
  
  private let defaultColor = Color.secondary
  private let intensiveColor = Color.red
  private let relaxedColor = Color.green
  private let focusedColor = Color.orange

  
  var body: some View {
    
    
    
    if workout.timer == nil {
      SetupView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor,
        focusedColor: focusedColor
      )
    }
    else {
      ExerciseView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor
      )
    }
    
  }
  
}
