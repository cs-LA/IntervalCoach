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
  
  let buttonFontSize: Int
  
  
  var body: some View {
    
    HStack(spacing: 5) {
      Text("repetitions")
        .font(.title)
        .foregroundColor(defaultColor)
      Spacer()
      Menu {
        Picker(selection: $workout.repetitions) {
          ForEach(1...99, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 1) {
          Text(String(workout.repetitions))
            .font(.system(.title, design: .monospaced))
            .foregroundColor(defaultColor)
          Text("x")
            .font(.title)
            .foregroundColor(defaultColor)
        }
      }
    }
    
    HStack(spacing: 5) {
      Text("intensiveTime")
        .font(.title)
        .foregroundColor(intensiveColor)
      Spacer()
      Menu {
        Picker(selection: $workout.intensiveTimeMinutes) {
          ForEach(0...99, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 1) {
          Text(String(workout.intensiveTimeMinutes))
            .font(.system(.title, design: .monospaced))
            .foregroundColor(intensiveColor)
          Text("'")
            .font(.title)
            .foregroundColor(intensiveColor)
        }
      }
      Menu {
        Picker(selection: $workout.intensiveTimeSeconds) {
          ForEach(0...59, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 1) {
          Text(String(format: "%02d", workout.intensiveTimeSeconds))
            .font(.system(.title, design: .monospaced))
            .foregroundColor(intensiveColor)
          Text("''")
            .font(.title)
            .foregroundColor(intensiveColor)
        }
      }
    }
    
    HStack(spacing: 5) {
      Text("relaxedTime")
        .font(.title)
        .foregroundColor(relaxedColor)
      Spacer()
      Menu {
        Picker(selection: $workout.relaxedTimeMinutes) {
          ForEach(0...99, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 1) {
          Text(String(workout.relaxedTimeMinutes))
            .font(.system(.title, design: .monospaced))
            .foregroundColor(relaxedColor)
          Text("'")
            .font(.title)
            .foregroundColor(relaxedColor)
        }
      }
      Menu {
        Picker(selection: $workout.relaxedTimeSeconds) {
          ForEach(0...59, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 1) {
          Text(String(format: "%02d", workout.relaxedTimeSeconds))
            .font(.system(.title, design: .monospaced))
            .foregroundColor(relaxedColor)
          Text("''")
            .font(.title)
            .foregroundColor(relaxedColor)
        }
      }
    }
    
    HStack(spacing: 5) {
      Spacer()
      Text(workout.errorMessage)
        .font(.callout)
        .foregroundColor(Color.blue)
      Spacer()
    }
    
  }
  
}
