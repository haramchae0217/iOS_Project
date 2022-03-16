//
//  AddAlarmViewController.swift
//  AlarmPractice
//
//  Created by Chae_Haram on 2022/03/08.
//

import UIKit

class AddAlarmViewController: UIViewController {

    @IBOutlet weak var alarmTimePicker: UIDatePicker!
    
    var addAlarm: Alarm?
    var row: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let addAlarm = addAlarm {
            alarmTimePicker.date = addAlarm.time
        }
        let rightBarButton = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(saveAlarm))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func saveAlarm() {
        let time = Alarm(time: alarmTimePicker.date)
        if let row = row {
            Alarm.alarmList[row] = time
        } else {
            Alarm.alarmList.append(time)
        }
        self.navigationController?.popViewController(animated: true)
        //self.navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    
}
