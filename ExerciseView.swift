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
  let focusedColor: Color

  let textFontSize: Int
  let buttonFontSize: Int

  
  var body: some View {
    
    ZStack {
      VStack {
        Spacer()
        Text(String(format: "%02d", workout.repCounter) + "/" + String(format: "%02d", workout.repetitions))
          .font(.system(size: CGFloat(textFontSize), design: .monospaced))
          .foregroundColor(defaultColor)
        Text(timeCountDown())
          .font(.system(size: CGFloat(textFontSize), design: .monospaced))
          .foregroundColor(progressBarColor())
       Spacer()
        if workout.timer == nil {
          Image(systemName: "play.fill")
            .font(.system(size: CGFloat(buttonFontSize)))
            .foregroundColor(focusedColor)
            .onTapGesture { workout.start() }
        }
        else {
          Image(systemName: "stop.fill")
            .font(.system(size: CGFloat(buttonFontSize)))
            .foregroundColor(focusedColor)
            .onTapGesture { workout.stop() }
        }
        Spacer()
      }
      
      ProgressCircle(gone: workout.secondsGone, toGo: workout.secondsToGo, color: progressBarColor())
    }
    
  }


  func timeCountDown() -> String {
    let currentTime = workout.secondsToGo - workout.secondsGone
    let seconds = currentTime % 60
    let minutes = currentTime / 60
    
    return String(format: "%02d", minutes) + ":" + String(format: "%02d", seconds)
  }

  
  private func progressBarColor() -> Color {
    if workout.timer == nil { return Color.gray }
    return workout.isIntensive ? intensiveColor : relaxedColor
  }
  
}
