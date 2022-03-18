//
//  MainScreen.swift
//

import Foundation
import SwiftUI


struct MainScreen: View {
  
  var workout: Workout
  
  init(workout: Workout) {
    self.workout = workout
    
    print(UIScreen.main.bounds.size)
    // iPhone8              ( 375.0,  667.0)
    // iPhone13mini         ( 375.0,  812.0)
    // iPadPro 12.9inch     (1024.0, 1366.0)

    //UIScrollView.appearance().bounces = false
  }
  
  let frameWidth = 345.0
  
  private let defaultColor = Color.secondary
  private let intensiveColor = Color(.systemRed)
  private let relaxedColor = Color(.systemGreen)

  
  var body: some View {
    
    VStack {
      Spacer()
      SetupView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor
      )
      Spacer()
      ExerciseView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor
      )
        .padding()
        .frame(height: frameWidth)
      Spacer()
      Text(appVersion)
        .font(.footnote)
    }
    .frame(width: frameWidth)
    .padding(15)

  }

}
