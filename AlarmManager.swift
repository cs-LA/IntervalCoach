//
//  AlarmManager.swift
//

import Foundation


struct AlarmManager {
  
  static func play(_ alarm: AlarmProtocol) {
    alarm.play()
  }
  
}
