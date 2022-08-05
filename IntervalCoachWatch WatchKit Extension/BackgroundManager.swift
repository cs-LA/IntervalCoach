//
//  BackgroundManager.swift (watchOS)
//

import Foundation
import SwiftUI


class BackgroundManager: BackgroundManagerProtocol {
  
  var xRtSession: WKExtendedRuntimeSession? = nil

  func enableBackgroundProcessing(_ workout: Workout? = nil) {
    xRtSession?.invalidate()
    xRtSession = WKExtendedRuntimeSession()
    xRtSession?.start()
  }
  
  func disableBackgroundProcessing() {
    xRtSession?.invalidate()
    xRtSession = nil
  }

}
