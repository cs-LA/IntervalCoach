//
//  AlarmHalfSplit.swift
//

import Foundation
import AVFoundation


struct AlarmHalfSplit: AlarmProtocol {
  
  var soundID = SystemSoundID(105)
  
  init() {
    // https://klingeltonmobi.de/download/?id=3568
    let intensiveHalfSplitURL = Bundle.main.url(forResource: "intensiveHalfSplit", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(intensiveHalfSplitURL! as CFURL, &soundID)
  }
  
  func play() {
    AudioServicesPlaySystemSound(soundID)
  }
  
}
