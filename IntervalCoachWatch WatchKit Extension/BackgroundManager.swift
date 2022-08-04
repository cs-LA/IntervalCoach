//
//  BackgroundManager.swift (watchOS)
//

import Foundation
import SwiftUI


class BackgroundManager: BackgroundManagerProtocol {
  
  var xRtSession: WKExtendedRuntimeSession? = nil

  func enableBackgroundProcessing(_ workout: Workout? = nil) { print("watchOS-BgMgr")
    print(xRtSession?.expirationDate as Any)
    xRtSession?.invalidate()
    xRtSession = WKExtendedRuntimeSession()
    xRtSession?.start()
  }
  
  func disableBackgroundProcessing() { print("watchOS-BgMgr")
    print(xRtSession?.expirationDate as Any)
    xRtSession?.invalidate()
    xRtSession = nil
  }

}
