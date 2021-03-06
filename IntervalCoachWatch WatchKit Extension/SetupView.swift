//
//  SetupView.swift
//

import Foundation
import SwiftUI


struct SetupView: View {
  
  @ObservedObject var workout: Workout
  
  let defaultColor: Color
  let intensiveColor: Color
  let relaxedColor: Color
  let focusedColor: Color
  
  @FocusState<Bool> var repetitionsFocused :Bool
  @FocusState<Bool> var intensiveMinutesFocused :Bool
  @FocusState<Bool> var intensiveSecondsFocused :Bool
  @FocusState<Bool> var relaxedMinutesFocused :Bool
  @FocusState<Bool> var relaxedSecondsFocused :Bool
  
  var body: some View {
    
    ScrollView() {
      VStack(spacing: 5) {
        
        HStack(spacing: 3) {
          Text("repetitions")
            .font(.footnote)
            .foregroundColor(defaultColor)
          Spacer()
          HStack(spacing: 1) {
            Text("\(Int(workout.repetitions))")
              .focusable(true)
              .focused($repetitionsFocused)
              .digitalCrownRotation($workout.repetitions, from: 0, through: 99, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(repetitionsFocused ? focusedColor : defaultColor)
            Text("x")
              .font(.system(.footnote))
              .foregroundColor(defaultColor)
          }
        }
        .padding(.top, 10)
        
        HStack(spacing: 3) {
          Text("intensiveTime")
            .font(.footnote)
            .foregroundColor(intensiveColor)
          Spacer()
          HStack(spacing: 1) {
            Text("\(Int(workout.intensiveTimeMinutes))")
              .focusable(true)
              .focused($intensiveMinutesFocused)
              .digitalCrownRotation($workout.intensiveTimeMinutes, from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(intensiveMinutesFocused ? focusedColor : intensiveColor)
            Text("'")
              .font(.system(.footnote))
              .foregroundColor(intensiveColor)
          }
          HStack(spacing: 1) {
            Text(workout.intensiveTimeSeconds < 10 ? "0\(Int(workout.intensiveTimeSeconds))" : "\(Int(workout.intensiveTimeSeconds))")
              .focusable(true)
              .focused($intensiveSecondsFocused)
              .digitalCrownRotation($workout.intensiveTimeSeconds, from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(intensiveSecondsFocused ? focusedColor : intensiveColor)
            Text("''")
              .font(.system(.footnote))
              .foregroundColor(intensiveColor)
          }
        }
        
        HStack(spacing: 3) {
          Text("relaxedTime")
            .font(.footnote)
            .foregroundColor(relaxedColor)
          Spacer()
          HStack(spacing: 1) {
            Text("\(Int(workout.relaxedTimeMinutes))")
              .focusable(true)
              .focused($relaxedMinutesFocused)
              .digitalCrownRotation($workout.relaxedTimeMinutes, from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(relaxedMinutesFocused ? focusedColor : relaxedColor)
            Text("'")
              .font(.system(.footnote))
              .foregroundColor(relaxedColor)
          }
          HStack(spacing: 1) {
            Text(workout.relaxedTimeSeconds < 10 ? "0\(Int(workout.relaxedTimeSeconds))" : "\(Int(workout.relaxedTimeSeconds))")
              .focusable(true)
              .focused($relaxedSecondsFocused)
              .digitalCrownRotation($workout.relaxedTimeSeconds, from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(relaxedSecondsFocused ? focusedColor : relaxedColor)
            Text("''")
              .font(.system(.footnote))
              .foregroundColor(relaxedColor)
          }
        }
        
        
//        HStack(spacing: 5) {
//          Spacer()
          Text(workout.errorMessage)
            .font(.system(.footnote))
            .foregroundColor(.blue)
//          Spacer()
//        }
        
        HStack(spacing: 5) {
          Image(systemName: "play.fill")
            .font(.system(.title))
            .foregroundColor(Color.orange)
            .onTapGesture { workout.start() }
//          Spacer()
//          Button(action: { workout.start() }) {
//            Image(systemName: "play.fill")
//              .font(.system(.title))
//              .foregroundColor(Color.orange)
//          }
//          Spacer()
        }
        
      }
      .padding(5)
    }
    
  }
  
}



