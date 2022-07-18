//
//  StartButton.swift
//

import Foundation
import SwiftUI


struct StartButton: View {
  
  //@ObservedObject
  var workout: Workout
  
  var body: some View {
    
    Button(action: { workout.start() }) {
      Image(systemName: "play.fill")
        .font(.system(size: 80))
        .foregroundColor(Color.orange)
    }
    
  }
  
}
