//
//  SetupView.swift
//

import Foundation
import SwiftUI


struct SetupView: View {
  
  @ObservedObject var workout: Workout
  @State var showInfo = false
  
  let defaultColor: Color
  let intensiveColor: Color
  let relaxedColor: Color
  let focusedColor: Color
  
  let buttonFontSize: Int
  
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
              .digitalCrownRotation($workout.repetitions.asFloat(), from: 0, through: 99, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
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
              .digitalCrownRotation($workout.intensiveTimeMinutes.asFloat(), from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(intensiveMinutesFocused ? focusedColor : intensiveColor)
            Text("'")
              .font(.system(.footnote))
              .foregroundColor(intensiveColor)
          }
          HStack(spacing: 1) {
            Text(String(format: "%02d", workout.intensiveTimeSeconds))
              .focusable(true)
              .focused($intensiveSecondsFocused)
              .digitalCrownRotation($workout.intensiveTimeSeconds.asFloat(), from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
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
              .digitalCrownRotation($workout.relaxedTimeMinutes.asFloat(), from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(relaxedMinutesFocused ? focusedColor : relaxedColor)
            Text("'")
              .font(.system(.footnote))
              .foregroundColor(relaxedColor)
          }
          HStack(spacing: 1) {
            Text(String(format: "%02d", workout.relaxedTimeSeconds))
              .focusable(true)
              .focused($relaxedSecondsFocused)
              .digitalCrownRotation($workout.relaxedTimeSeconds.asFloat(), from: 0, through: 59, by: 1.0, sensitivity: .medium, isContinuous: false, isHapticFeedbackEnabled: true)
              .font(.system(.footnote, design: .monospaced))
              .foregroundColor(relaxedSecondsFocused ? focusedColor : relaxedColor)
            Text("''")
              .font(.system(.footnote))
              .foregroundColor(relaxedColor)
          }
        }
        
        
        HStack(spacing: 5) {
          Spacer()
          Image(systemName: "play.fill")
            .font(.system(size: CGFloat(buttonFontSize)))
            .foregroundColor(focusedColor)
            .onTapGesture { workout.start() }
          Spacer()
        }
        .padding(.top, 20)
        .padding(.bottom, 5)
        .contentShape(Rectangle())
        .onLongPressGesture(perform: {
          print("longPressed")
          showInfo = true
        })
        .alert(isPresented: $showInfo) {
          Alert(
            title: Text("IntervalCoachWatch"),
            message: Text(appVersion),
            dismissButton: .default(Text("OK"))
          )
        }
        
      }
      .padding(5)
    }
    
  }
  
}


extension Binding where Value == Int {
  
  public func asFloat() -> Binding<Float> {
    return Binding<Float>(
      get: { Float(self.wrappedValue) },
      set: { self.wrappedValue = Int($0) }
    )
  }
  
}
