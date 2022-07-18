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
        Text("\(twoDigitNumber(workout.repCounter))/\(twoDigitNumber(Int(workout.repetitions)))")
          .font(.system(.title2, design: .monospaced))
          .foregroundColor(defaultColor)
        //Spacer()
        Text(timeCountDown())
          .font(.system(.title2, design: .monospaced))
          .foregroundColor(workout.isIntensive ? intensiveColor : relaxedColor)
        Spacer()
        Image(systemName: "stop.fill")
          .font(.system(.title))
          .foregroundColor(Color.orange)
          .onTapGesture { workout.stop() }
//        Button(action: { workout.stop() }) {
//          Image(systemName: "stop.fill")
//            .font(.system(.title))
//            .foregroundColor(Color.orange)
//        }
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
