//
//  ViewController.swift
//  롤자 사다리타기
//
//  Created by Chae_Haram on 2023/01/25.
//

import UIKit

class ViewController: UIViewController {
    
    var nameList: [String] = []
    var firstTeamList: [String] = []
    var secondTeamList: [String] = []
    var shuffleList: [String] = []
    
    @IBOutlet weak var addNameTextField: UITextField!
    @IBOutlet weak var nameListLabel: UILabel!
    @IBOutlet weak var firstTeamLabel: UILabel!
    @IBOutlet weak var secondTeamLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func addNameButton(_ sender: UIButton) {
        let name = addNameTextField.text!
        if name == "" {
            UIAlertController.warningAlert(title: "🚫", message: "빈칸을 입력해주세요.", viewController: self)
        } else {
            if nameList.count < 10 {
                nameList.append(name)
                showName()
            } else {
                UIAlertController.warningAlert(title: "🚫", message: "10명이 초과되었습니다.", viewController: self)
            }
        }
        addNameTextField.text = ""
    }
    
    @IBAction func deleteNameButton(_ sender: UIButton) {
        let name = addNameTextField.text!
        if name == "" {
            nameList.removeLast()
        } else {
            
            
        }
        showName()
    }
    
    @IBAction func makeTeamButton(_ sender: UIButton) {
        shuffleList = []
        firstTeamList = []
        secondTeamList = []
        makeTeam()
        showTeam()
    }
    
    @IBAction func resetTeamButton(_ sender: UIButton) {
        nameList.removeAll()
        firstTeamList.removeAll()
        secondTeamList.removeAll()
        showName()
    }
    
    func showName() {
        var name: String = ""
        for i in 0..<nameList.count {
            if i == nameList.count - 1 {
                name.append("\(i+1). \(nameList[i])")
                break
            }
            name.append("\(i+1). \(nameList[i])\n")
        }
        nameListLabel.text = name
    }
    
    func makeTeam() {
        if nameList.count < 10 {
            UIAlertController.warningAlert(title: "🚫", message: "명단 10명을 채워주세요.", viewController: self)
        } else {
            shuffleList = nameList.shuffled()
            print(shuffleList)
            for i in 0...9 {
                if i < 5 {
                    firstTeamList.append(shuffleList[i])
                } else {
                    secondTeamList.append(shuffleList[i])
                }
            }
        }
    }
    
    func showTeam() {
        var firstTeam: String = ""
        var secondTeam: String = ""
        for i in 0..<firstTeamList.count {
            if i == firstTeamList.count - 1 {
                firstTeam.append("\(i+1). \(firstTeamList[i])")
                break
            }
            firstTeam.append("\(i+1). \(firstTeamList[i])\n")
        }
        
        for i in 0..<secondTeamList.count {
            if i == secondTeam.count - 1 {
                secondTeam.append("\(i+1). \(secondTeamList[i])")
                break
            }
            secondTeam.append("\(i+1). \(secondTeamList[i])\n")
        }
        firstTeamLabel.text = firstTeam
        secondTeamLabel.text = secondTeam
    }
    
}

