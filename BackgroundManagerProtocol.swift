//
//  BackgroundManagerProtocol.swift
//

import Foundation


protocol BackgroundManagerProtocol {
  
  func enableBackgroundProcessing(_ workout: Workout?)
  func disableBackgroundProcessing()
  
}
