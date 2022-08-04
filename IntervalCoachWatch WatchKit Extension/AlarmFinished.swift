//
//  AlarmFinished.swift
//

import Foundation
import SwiftUI


struct AlarmFinished: AlarmProtocol {
  
  func play() {
    WKInterfaceDevice.current().play(.success)
  }
  
}
