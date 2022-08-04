//
//  AlarmStart.swift (watchOS)
//

import Foundation
import SwiftUI


struct AlarmStart: AlarmProtocol {
  
  func play() {
    WKInterfaceDevice.current().play(.start)
  }
  
}
