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
        Text("\(twoDigitNumber(workout.repCounter))/\(twoDigitNumber(Int(workout.repetitions)))")
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
    let minutes = Int(currentTime / 60)
    
    return "\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
  }

  
  func twoDigitNumber(_ number: Int) -> String {
    return "\(number < 10 ? "0" : "")\(number)"
  }
  
  
  private func progressBarColor() -> Color {
    if workout.timer == nil { return Color.gray }
    return workout.isIntensive ? intensiveColor : relaxedColor
  }
  
}
