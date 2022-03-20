//
//  UIAlertController++Extension.swift
//  ContactProject
//
//  Created by Chae_Haram on 2022/03/19.
//

import UIKit

extension UIAlertController {
    static func showAlert(message: String, vc: UIViewController) {
        // 1. alert 만들기
        let alert = UIAlertController(title: "⚠️", message: message , preferredStyle: .alert)
        // 2. button 만들기
        let doneButton = UIAlertAction(title: "확인", style: .default, handler: nil)
        let cancelButton = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        alert.addAction(doneButton)
        
        // 3. present 하기
        vc.present(alert, animated: true, completion: nil)
        
    }
}
