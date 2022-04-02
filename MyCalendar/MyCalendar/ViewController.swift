//
//  ViewController.swift
//  MyCalendar
//
//  Created by Chae_Haram on 2022/03/31.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var schedulesLabel: UILabel!
    
    
    var events: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addEvents()
    }

    func configure() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.locale = Locale(identifier: "ko-KR")
        
        calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
        
        //calendarView.scrollDirection = .vertical //수직
        calendarView.appearance.borderRadius = 0 // 사각형
        
        calendarView.appearance.selectionColor = .systemMint
        calendarView.appearance.todayColor = .systemPink
        calendarView.appearance.headerTitleColor = .brown
        
    }
    func addEvents() {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko-KR")
        dateFormatter.dateFormat = "yyyy/MM/dd"
        let foolsDay = dateFormatter.date(from: "2022/04/01")
        let yesterday = dateFormatter.date(from: "2022/03/30")
        
        events.append(foolsDay!)
        events.append(yesterday!)
    }

}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if events.contains(date) {
            return 1
        } else {
            return 0
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if events.contains(date) {
            print("이벤트 있음")
            // 화면 전환 코드, 데이터 리로드 코드
        }
    }
}
