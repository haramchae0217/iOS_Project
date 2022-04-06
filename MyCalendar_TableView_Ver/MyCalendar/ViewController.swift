//
//  ViewController.swift
//  MyCalendar
//
//  Created by KEEN on 2022/03/31.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy/MM/dd"
    df.locale = Locale(identifier: "ko-KR")
    return df
  }()

  @IBOutlet weak var calendarView: FSCalendar!
  @IBOutlet weak var dateLabel: UILabel!
    
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    makeTestData()
  }
  
  func configure() {
    calendarView.delegate = self
    calendarView.dataSource = self
   
    calendarView.locale = Locale(identifier: "ko-KR")
    
    calendarView.appearance.selectionColor = .systemMint
    calendarView.appearance.todayColor = .systemGray
    calendarView.appearance.headerTitleColor = .systemBrown
   
  }
  
  func makeTestData() {
    let list: [Schedule] = [
      Schedule(time: "오후 12시", title: "점심 먹기", date: strToDate(str: "2022/04/01")),
      Schedule(time: "오후  1시", title: "발표 하기", date: strToDate(str: "2022/04/01")),
      Schedule(time: "오후  3시", title: "프로젝트 회의", date: strToDate(str: "2022/04/01")),
      Schedule(time: "오전  8시", title: "기상", date: strToDate(str: "2022/04/04")),
      Schedule(time: "오전 10시", title: "모의 시험", date: strToDate(str: "2022/04/04")),
      Schedule(time: "오후  1시", title: "스터디", date: strToDate(str: "2022/04/06")),
      Schedule(time: "오후  3시", title: "과외", date: strToDate(str: "2022/04/11")),
      Schedule(time: "오후  5시", title: "과제하기", date: strToDate(str: "2022/04/13")),
      Schedule(time: "오전 11시", title: "본가 가기", date: strToDate(str: "2022/04/13")),
      Schedule(time: "오후  7시", title: "00이랑 술 약속", date: strToDate(str: "2022/04/20"))
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
    for schedule in MyDB.dataList {
      let eventDate = schedule.date
      
      if eventDate == date {
        let count = MyDB.dataList.filter { schedule in
          schedule.date == date
        }.count
        
        if count >= 3 {
          return 3
        } else {
          return count
        }
      }
    }
    
    return 0
  }
  
  func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    dateLabel.text = dateFormatter.string(from: date)
    
    let scheduleList = MyDB.dataList.filter { schedule in
      schedule.date == date
    }
    
    if scheduleList.count > 0 {
      
      var text: String = ""
      
      for s in scheduleList {
        text.append("\(s.time) > \(s.title) \n")
      }
      
      //scheduleLabel.text = text
    } else {
      //scheduleLabel.text = "오늘은 스케쥴이 없습니다."
    }
  }
}
