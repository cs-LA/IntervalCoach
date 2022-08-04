//
//  AlarmFinished.swift
//

import Foundation
import AVFoundation


struct AlarmFinished: AlarmProtocol {
  
  var soundID = SystemSoundID(199)
  
  init() {
    // http://www.kenaston.org/the-referee-fitness/whistle-mp3/08-whistle-end-of-game.mp3
    let workoutFinishedURL = Bundle.main.url(forResource: "workoutFinished", withExtension: "mp3")
    AudioServicesCreateSystemSoundID(workoutFinishedURL! as CFURL, &soundID)
  }
  
  func play() {
    AudioServicesPlaySystemSound(soundID)
  }
  
}
