//
//  UIAlertController++Extension.swift
//  MemoPractice
//
//  Created by Chae_Haram on 2022/02/02.
//

import UIKit

extension UIAlertController {
    static func showAlert(message: String, vc: UIViewController) {
        // 1. alert 만들기
        let alert = UIAlertController(title: "⚠️", message: message , preferredStyle: .alert)
        // 2. button 만들기
        let cancelButton = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        alert.addAction(cancelButton)
        // 3. present 하기
        vc.present(alert, animated: true, completion: nil)
        
    }
}

