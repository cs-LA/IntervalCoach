//
//  MainScreen.swift
//

import Foundation
import Combine
import SwiftUI


struct MainScreen: View {
  
  @ObservedObject var workout: Workout
  
  init(workout: Workout) {
    self.workout = workout
    UIScrollView.appearance().bounces = false
    print(UIScreen.main.bounds.size)
    // iPhone8              (375.0, 667.0)
    // iPhone13mini         (375.0, 812.0)
    // iPadPro 12.9inch     (1024.0, 1366.0)
  }
  
  @State private var errorText = ""
  
  private let fieldWidth: CGFloat = 39
  private let defaultColor = Color.secondary
  private let intensiveColor = Color(.systemRed)
  private let relaxedColor = Color(.systemGreen)
  @State private var progressColor = Color(.systemYellow)
  
  var body: some View {
    
    VStack {
      
      Spacer()
      
      repetitionsView()
      intensiveTimeView()
      relaxedTimeView()

      Button(action: { workout.timer == nil ? workout.start() : workout.stop() }) {
        Text(workout.timer == nil ? "start" : "stop")
          .font(.title)
          .fontWeight(.bold)
          .padding(.vertical, 15)
          .padding(.horizontal, 100)
          .background(Color(.systemYellow))
          .foregroundColor(Color.black)
          .cornerRadius(10)
      }
      .frame(minWidth: 0, maxWidth: .infinity)
      .padding()
      
      Spacer()
      
      ZStack {
        Text("\(workout.repCounter)")
          .font(.largeTitle)
          .padding(.bottom, 150)
        CountDownView(
          progressColor: progressBarColor(),
          counter: workout.secondsGone,
          countTo: workout.secondsToGo
        )
      }

      Spacer()

    }
    .frame(width: 345)
    //.border(Color.yellow)
    .padding(15)
    //.ignoresSafeArea(.keyboard)

  }


  private func progressBarColor() -> Color {
    if workout.timer == nil { return Color(.systemGray) }
    return workout.isIntensive ? intensiveColor : relaxedColor
  }
  
  
  
  @ViewBuilder
  private func intensiveTimeView() -> some View {
    
    HStack(spacing: 5) {
      
      Text("intensiveTime")
        .font(.title)
        .foregroundColor(intensiveColor)
      
      Spacer()
      
      Menu {
        Picker(selection: $workout.intensiveTimeMinutes) {
          ForEach(0...99, id: \.self) {
            Text("\($0)")
              .font(.title)
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
            Text("\($0)")
              .font(.title)
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

  }
  
  
  @ViewBuilder
  private func relaxedTimeView() -> some View {
    
    HStack(spacing: 5) {
      
      Text("relaxedTime")
        .font(.title)
        .foregroundColor(relaxedColor)
      
      Spacer()
      
      Menu {
        Picker(selection: $workout.relaxedTimeMinutes) {
          ForEach(0...99, id: \.self) {
            Text("\($0)")
              .font(.title)
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
            Text("\($0)")
              .font(.title)
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

  }
  
  
  
  @ViewBuilder
  private func repetitionsView() -> some View {
    
    HStack(spacing: 5) {
      
      Text("repetitions")
        .font(.title)
        .foregroundColor(defaultColor)
      
      Spacer()
      
      Menu {
        Picker(selection: $workout.repetitions) {
          ForEach(1...99, id: \.self) {
            Text("\($0)")
              .font(.title)
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

  }
}
