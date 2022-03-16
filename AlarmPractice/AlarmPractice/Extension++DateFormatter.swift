//
//  Extension++DateFormatter.swift
//  AlarmPractice
//
//  Created by Chae_Haram on 2022/03/08.
//

import Foundation

extension DateFormatter {
    // yyyy/MM/dd
    
    // 문자열 -> 날짜
    func toTime(target: String) -> Date {
        self.dateFormat = "a hh:mm"
        return self.date(from: target)!
    }
    
    
    // 날짜 -> 문자열
    func toString(target: Date) -> String {
        self.dateFormat = "a hh:mm"
        return self.string(from: target)
    }
}
