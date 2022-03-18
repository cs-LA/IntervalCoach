//
//  AppInfos.swift
//

import Foundation
import SwiftUI


let appName = Bundle.main.appName
let appVersion = Bundle.main.version
let appIdentifier = Bundle.main.bundleIdentifier!
var appBuildDate: String {
  get {
    let bundleName = Bundle.main.infoDictionary!["CFBundleName"] as? String ?? "Info.plist"
    guard let infoPath = Bundle.main.path(forResource: bundleName, ofType: nil)
    else { return "0000-01-01" }
    guard let infoAttr = try? FileManager.default.attributesOfItem(atPath: infoPath)
    else { return "0000-01-01" }
    let key = FileAttributeKey(rawValue: "NSFileCreationDate")
    guard let infoDate = infoAttr[key] as? Date
    else { return "0000-01-01" }
    
    let df = DateFormatter()
    df.dateFormat = "YYYY-MM-dd-HH:mm"
    return df.string(from: infoDate)
  }
}


extension Bundle {
  
  var appName: String {
    return infoDictionary?["CFBundleExecutable"] as! String
  }
  
  var releaseVersionNumber: String? {
    return infoDictionary?["CFBundleShortVersionString"] as? String
  }
  
  var buildVersionNumber: String? {
    return infoDictionary?["CFBundleVersion"] as? String
  }
  
  var version: String {
    return "\(releaseVersionNumber ?? "?.?").\(buildVersionNumber?.leftPadded(toLength: 3, withPad: "0") ?? "??")"
  }
  
}


extension String {
  
  func leftPadded(toLength: Int, withPad character: Character) -> String {
    let stringLength = self.count
    if stringLength < toLength {
      return String(repeatElement(character, count: toLength - stringLength)) + self
    } else {
      return String(self.suffix(toLength))
    }
  }
  
}
