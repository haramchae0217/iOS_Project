//
//  Memo.swift
//  MemoPractice
//
//  Created by Chae_Haram on 2022/02/02.
//

//model 생성
import Foundation

struct Memo {
    var content: String
    var date: Date = Date()
    
    // 메모를 담을 배열을 static으로 선언
    static var memoList: [Memo] = [
        Memo(content: "memo1", date: DateFormatter.customDateFormatter.date(from: "2022/02/01 화요일 16:21")!),
        Memo(content: "memo2"),
        Memo(content: "memo3")
    ].sorted { lhs, rhs in
        lhs.date < rhs.date
    }
}

