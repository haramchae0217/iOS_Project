//
//  ViewController.swift
//  AlarmPractice
//
//  Created by Chae_Haram on 2022/03/07.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var alarmTableView: UITableView!
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "a hh:mm"
        df.locale = Locale(identifier: "ko-KR")
        df.timeZone = TimeZone(abbreviation: "KST")
        df.dateStyle = .medium
        df.timeStyle = .medium
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alarmTableView.dataSource = self
        alarmTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let sortedList = Alarm.alarmList.sorted { lhs, rhs in
            lhs.time < rhs.time
        }
        Alarm.alarmList = sortedList
        alarmTableView.reloadData()
        
    }
    
    @IBAction func addAlarmButton(_ sender: UIBarButtonItem) {
        guard let addVC = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as? AddAlarmViewController else { return }
        addVC.title = "알람 추가"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(addVC, animated: true)
        //self.navigationController?.present(addVC, animated: true, completion: nil)
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlarmTVC", for: indexPath) as? AlarmItemTableViewCell else { return UITableViewCell() }
        let alarm = Alarm.alarmList[indexPath.row]
        cell.alarmTimeLabel.text = dateFormatter.toString(target: alarm.time)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Alarm.alarmList.count
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Alarm.alarmList.remove(at: indexPath.row)
            // 실제 배열 안의 값을 지움
            tableView.deleteRows(at: [indexPath], with: .fade)
            // 사라지는 방향
        } else {
            print("insert")
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let editVC = self.storyboard?.instantiateViewController(withIdentifier: "addVC") as? AddAlarmViewController else { return }
        editVC.title = "알람 수정"
        editVC.addAlarm = Alarm.alarmList[indexPath.row]
        editVC.row = indexPath.row
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(editVC, animated: true)
        //self.navigationController?.present(editVC, animated: true, completion: nil)
    }
}
