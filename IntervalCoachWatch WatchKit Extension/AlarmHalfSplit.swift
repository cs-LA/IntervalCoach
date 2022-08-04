//
//  AlarmHalfSplit.swift
//

import Foundation
import SwiftUI


struct AlarmHalfSplit: AlarmProtocol {
  
  func play() {
    WKInterfaceDevice.current().play(.retry)
  }
  
}
