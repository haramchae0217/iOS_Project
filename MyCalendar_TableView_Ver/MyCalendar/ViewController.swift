//
//  ViewController.swift
//  MyCalendar
//
//  Created by KEEN on 2022/03/31.
//

import UIKit
import FSCalendar
/*
 // 로직을 짠다. 어떻게 하는 걸까?
 1. 모델을 설정한다.(모델 & DB) -> 어떤 데이터가 필요하고, 어디에 어떻게 뿌려줄것인가.
 2. UI 잡기 -> cell에 대한 설정을 한는 등 디테일한 설정을 모델을 바탕으로 잡기.
 3. 화면 흐름(전환 순서) == 데이터의 흐름
 4. 세세한 설정 -> 화면을 띄워주는 방식, UI 커스텀
 */

class ViewController: UIViewController {
  
  let dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy/MM/dd"
    df.locale = Locale(identifier: "ko-KR")
    return df
  }()

  @IBOutlet weak var calendarView: FSCalendar!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var scheduleLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configure()
    makeTestData()
  }
  
  func configure() {
    calendarView.delegate = self
    calendarView.dataSource = self
   
    // calendarView.scrollDirection = .vertical
    // calendarView.appearance.borderRadius = 0
    calendarView.locale = Locale(identifier: "ko-KR")
    
    calendarView.appearance.selectionColor = .systemMint
    calendarView.appearance.todayColor = .systemGray
    calendarView.appearance.headerTitleColor = .systemBrown
    // calendarView.calendarWeekdayView.weekdayLabels[3].text = "WED"
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
  // 1개,2개,3개,4개,5개 -> 점갯수는 최대 3개
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
    // 데이터 있을 때 -> "00개의 스케쥴이 있습니다."
    // 데이터가 없을 때 -> "오늘은 스케쥴이 없습니다."
    /*
     오후 1시 > 점심먹기
     오후 2시 > 공부하기
     */
    
    let scheduleList = MyDB.dataList.filter { schedule in
      schedule.date == date
    }
    
    if scheduleList.count > 0 {
      
      var text: String = ""
      
      for s in scheduleList {
        text.append("\(s.time) > \(s.title) \n")
      }
      
      scheduleLabel.text = text
    } else {
      scheduleLabel.text = "오늘은 스케쥴이 없습니다."
    }
  }
}
