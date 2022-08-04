//
//  AlarmStop.swift (iOS)
//

import Foundation
import AVFoundation


struct AlarmStop: AlarmProtocol {
  
  var soundID = SystemSoundID(109)
  
  init() {
    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/02-whistle-kick.mp3
    let stopIntensiveURL = Bundle.main.url(forResource: "intensiveStop", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(stopIntensiveURL! as CFURL, &soundID)
  }
  
  func play() {
    AudioServicesPlaySystemSound(soundID)
  }
  
}
