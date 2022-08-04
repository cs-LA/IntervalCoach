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
  private let textFontSize = 24
  private let buttonFontSize = 36

  
  var body: some View {
    
    if workout.timer == nil {
      SetupView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor,
        focusedColor: focusedColor,
        buttonFontSize: buttonFontSize
      )
    }
    else {
      ExerciseView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor,
        focusedColor: focusedColor,
        textFontSize: textFontSize,
        buttonFontSize: buttonFontSize
      )
    }
    
  }
  
}
