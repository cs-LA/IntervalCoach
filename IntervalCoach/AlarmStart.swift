//
//  AlarmStart.swift (iOS)
//

import Foundation
import AVFoundation


struct AlarmStart: AlarmProtocol {
  
  var soundID = SystemSoundID(101)

  init() {
    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/01-whistle-captians.mp3
    let startIntensiveURL = Bundle.main.url(forResource: "intensiveStart", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(startIntensiveURL! as CFURL, &soundID)
  }

  func play() {
    AudioServicesPlaySystemSound(soundID)
  }
  
}
