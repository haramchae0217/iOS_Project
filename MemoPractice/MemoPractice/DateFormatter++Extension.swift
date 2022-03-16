//
//  DateFormatter++Extension.swift
//  MemoPractice
//
//  Created by Chae_Haram on 2022/02/02.
//

import UIKit

extension DateFormatter{
    static let customDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ko-KR")
        df.dateFormat = "yyyy/MM/dd EEEE HH:mm"
        return df
    }()
}
