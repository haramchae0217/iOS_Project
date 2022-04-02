//
//  ViewController.swift
//  MyCalendar
//
//  Created by Chae_Haram on 2022/03/31.
//

import UIKit
import FSCalendar

/*
    로직을 짠다. how to..
 1. 모델을 설정한다(모델 & DB) -> 어떤 데이터가 필요하고, 어디에 어떻게 뿌려줄것인가?
 2. UI 잡기 -> cell에 대한 설정은 하는 등, 디테일한 설정을 모델을 바탕으로 잡기.
 3. 화면 흐름도 -> 전환 순서 == 데이터의 흐름
 4. 세세한 설정 -> 화면 띄워주는 방식, ui 커스텀(색깔등등)
 */

class ViewController: UIViewController {
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
        df.locale = Locale(identifier: "ko-KR")
        return df
    }()

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var schedulesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        makeTestData()
    
    }

    func configure() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.locale = Locale(identifier: "ko-KR")
        
//        calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
        
        //calendarView.scrollDirection = .vertical //수직
        calendarView.appearance.borderRadius = 0 // 사각형
        
        calendarView.appearance.selectionColor = .systemMint
        calendarView.appearance.todayColor = .systemPink
        calendarView.appearance.headerTitleColor = .brown
        
    }
    
    func makeTestData() {
        let list: [Schedule] = [
              Schedule(time: "오후 12시", title: "점심 먹기", date: strToDate(str: "2022-04-01")),
              Schedule(time: "오후  1시", title: "발표 하기", date: strToDate(str: "2022-04-01")),
              Schedule(time: "오후  3시", title: "프로젝트 회의", date: strToDate(str: "2022-04-01")),
              Schedule(time: "오전  8시", title: "기상", date: strToDate(str: "2022-04-04")),
              Schedule(time: "오전 10시", title: "모의 시험", date: strToDate(str: "2022-04-04")),
              Schedule(time: "오후  1시", title: "스터디", date: strToDate(str: "2022-04-06")),
              Schedule(time: "오후  3시", title: "과외", date: strToDate(str: "2022-04-11")),
              Schedule(time: "오후  5시", title: "과제하기", date: strToDate(str: "2022-04-13")),
              Schedule(time: "오전 11시", title: "본가 가기", date: strToDate(str: "2022-04-13")),
              Schedule(time: "오후  7시", title: "00이랑 술 약속", date: strToDate(str: "2022-04-20"))
            ]
        list.forEach { schedule in
            MyDB.dataList.append(schedule)
        }
    }
    
    func strToDate(str: String) -> Date {
        return dateFormatter.date(from: str)!
    }
}

extension ViewController: FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return 0
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
            // 화면 전환 코드, 데이터 리로드 코드
        
    }
}
