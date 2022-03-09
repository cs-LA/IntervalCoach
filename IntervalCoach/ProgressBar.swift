//
//  ProgressBar.swift
//

import Foundation
import SwiftUI


// This view is the “track” of the progress bar,
// meaning what is displayed
// when the progress bar is not filled.
// We’re using the fact that we need an overlay
// to have a stroke effect on a shape.
struct ProgressTrack: View {
  var body: some View {
    Circle()
      .fill(Color.clear)
      //.frame(width: 250, height: 250)
      .overlay(
        Circle().stroke(Color.secondary, lineWidth: 15)
      )
  }
}


// This one is where the entire circular progress is made.
// Worth noting is the color changing to green
// when it’s complete.
struct ProgressBar: View {
  
  var counter: Int
  var countTo: Int
  var color: Color
  
  var body: some View {
    Circle()
      .fill(Color.clear)
      //.frame(width: 250, height: 250)
      .overlay(
        Circle().trim(from:0, to: CGFloat(counter) / CGFloat(countTo))
          .stroke(
            style: StrokeStyle(
              lineWidth: 15,
              lineCap: .round,
              lineJoin:.round
            )
          )
          .rotationEffect(.degrees(-90))
          .foregroundColor(color)
      )
  }
  
}
