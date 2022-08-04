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

  private let fieldWidth: CGFloat = 39

  
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
        HStack(spacing: 2) {
          TextField("", value: $workout.repetitions, format: .number)
            .font(.title)
            .foregroundColor(defaultColor)
            .multilineTextAlignment(.trailing)
            .frame(width: fieldWidth, height: 30)
          Text("x")
            .font(.title)
            .foregroundColor(defaultColor)
            .multilineTextAlignment(.trailing)
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
        HStack(spacing: 2) {
          TextField("", value: $workout.intensiveTimeMinutes, format: .number)
            .font(.title)
            .foregroundColor(intensiveColor)
            .multilineTextAlignment(.trailing)
            .frame(width: fieldWidth, height: 30)
          Text("'")
            .font(.title)
            .foregroundColor(intensiveColor)
            .multilineTextAlignment(.trailing)
        }
      }
      Menu {
        Picker(selection: $workout.intensiveTimeSeconds) {
          ForEach(0...59, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 2) {
          TextField("", value: $workout.intensiveTimeSeconds, format: .number)
            .font(.title)
            .foregroundColor(intensiveColor)
            .multilineTextAlignment(.trailing)
            .frame(width: fieldWidth, height: 30)
          Text("''")
            .font(.title)
            .foregroundColor(intensiveColor)
            .multilineTextAlignment(.trailing)
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
        HStack(spacing: 2) {
          TextField("", value: $workout.relaxedTimeMinutes, format: .number)
            .font(.title)
            .foregroundColor(relaxedColor)
            .multilineTextAlignment(.trailing)
            .frame(width: fieldWidth, height: 30)
          Text("'")
            .font(.title)
            .foregroundColor(relaxedColor)
            .multilineTextAlignment(.trailing)
        }
      }
      Menu {
        Picker(selection: $workout.relaxedTimeSeconds) {
          ForEach(0...59, id: \.self) {
            Text("\($0)").font(.title)
          }
        } label: {}
      } label: {
        HStack(spacing: 2) {
          TextField("", value: $workout.relaxedTimeSeconds, format: .number)
            .font(.title)
            .foregroundColor(relaxedColor)
            .multilineTextAlignment(.trailing)
            .frame(width: fieldWidth, height: 30)
          Text("''")
            .font(.title)
            .foregroundColor(relaxedColor)
            .multilineTextAlignment(.trailing)
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
