//
//  ProgressCircle.swift
//

import Foundation
import SwiftUI


struct ProgressCircle: View {
  
  var gone: Int
  var toGo: Int
  var color: Color

  
  var body: some View {
    
    // BackgroundTrack
    // This view is the “track” of the progress bar,
    // meaning what is displayed when the progress circle is not filled.
    // We’re using the fact that we need an overlay to have a stroke effect on a shape.
    Circle()
      .fill(Color.clear)
      .overlay(
        Circle().stroke(Color.secondary, lineWidth: 15)
      )
    
    // ProgressCircle
    // This one is where the entire circular progress is shown.
    Circle()
      .fill(Color.clear)
      .overlay(
        Circle().trim(from: 0, to: CGFloat(gone) / CGFloat(toGo))
          .stroke(
            style: StrokeStyle(
              lineWidth: 15,
              lineCap: .round,
              lineJoin: .round
            )
          )
          .rotationEffect(.degrees(-90))
          .foregroundColor(color)
      )
    
  }
  
}
