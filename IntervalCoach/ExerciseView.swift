//
//  ExerciseView.swift
//

import Foundation
import SwiftUI


struct ExerciseView: View {
  
  @ObservedObject var workout: Workout

  let defaultColor: Color
  let intensiveColor: Color
  let relaxedColor: Color
  
  
  var body: some View {
    
    ZStack {
      VStack {
        Spacer()
        Text("\(workout.repCounter)")
          .font(.largeTitle)
        Spacer()
        Text(timeCountDown())
          .font(.system(size: 60, design: .monospaced))
        Spacer()
        if workout.timer == nil { StartButton(workout: workout) }
        else { StopButton(workout: workout) }
        Spacer()
      }
      
      ProgressCircle(gone: workout.secondsGone, toGo: workout.secondsToGo, color: progressBarColor())
    }
    
  }


  func timeCountDown() -> String {
    let currentTime = workout.secondsToGo - workout.secondsGone
    let seconds = currentTime % 60
    let minutes = Int(currentTime / 60)
    
    return "\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
  }

  
  private func progressBarColor() -> Color {
    if workout.timer == nil { return Color(.systemGray) }
    return workout.isIntensive ? intensiveColor : relaxedColor
  }
  
}
