//
//  CountDownView.swift
//

import Foundation
import SwiftUI


struct CountDownView: View {
  
  var progressColor: Color
  var counter: Int
  var countTo: Int
  
  var body: some View {
    VStack{
      ZStack{
        ProgressTrack()
        ProgressBar(counter: counter, countTo: countTo, color: progressColor)
        ClockView(counter: counter, countTo: countTo)
      }
      .padding()
    }
  }
  
}

