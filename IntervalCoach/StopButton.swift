//
//  StopButton.swift
//

import Foundation
import SwiftUI


struct StopButton: View {
  
  @ObservedObject var workout: Workout
  
  var body: some View {
    
    Button(action: { workout.stop() }) {
      Image(systemName: "stop.fill")
        .font(.system(size: 80))
        .foregroundColor(Color.orange)
    }
    
  }
  
}
