//
//  StringFormattingHelper.swift
//  Seetube
//
//  Created by 최수정 on 2023/03/06.
//

import Foundation

class StringFormattingHelper {
    static func toTimeFormatString(seconds: Int) -> String {
        let min = seconds / 60
        let sec = seconds % 60
        return String(format: "%02d", min) + ":" + String(format: "%02d", sec)
    }
    
    static func toTimeIntervalFormatString(startSecond: Int, endSecond: Int) -> String {
        let startTimeString = Self.toTimeFormatString(seconds: startSecond)
        let endTimeString = Self.toTimeFormatString(seconds: endSecond)
        let interval = startTimeString + " - " + endTimeString
        
        return interval
    }
}
