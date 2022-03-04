//
//  ClockView.swift
//

import Foundation
import SwiftUI

struct ClockView: View {
  
  var counter: Int
  var countTo: Int
  
  var body: some View {
    VStack {
      Text(counterToMinutes())
        .font(.system(size: 60, design: .monospaced))
    }
  }
  
  func counterToMinutes() -> String {
    let currentTime = countTo - counter
    let seconds = currentTime % 60
    let minutes = Int(currentTime / 60)
    
    return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
  }
  
}

