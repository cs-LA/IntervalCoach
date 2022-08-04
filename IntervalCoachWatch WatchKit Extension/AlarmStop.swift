//
//  AlarmStop.swift (watchOS)
//

import Foundation
import SwiftUI


struct AlarmStop: AlarmProtocol {
  
  func play() {
    WKInterfaceDevice.current().play(.stop)
  }
  
}
