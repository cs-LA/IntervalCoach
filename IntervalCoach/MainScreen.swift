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
  private let focusedColor = Color(.systemOrange)
  private let textFontSize = 50
  private let buttonFontSize = 100
  
  var body: some View {
    
    VStack {
      Spacer()
      SetupView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor,
        focusedColor: focusedColor,
        buttonFontSize: buttonFontSize
      )
      Spacer()
      ExerciseView(
        workout: workout,
        defaultColor: defaultColor,
        intensiveColor: intensiveColor,
        relaxedColor: relaxedColor,
        focusedColor: focusedColor,
        textFontSize: textFontSize,
        buttonFontSize: buttonFontSize
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
