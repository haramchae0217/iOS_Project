//
//  UIAlertController++Extension.swift
//  롤자 사다리타기
//
//  Created by Chae_Haram on 2023/01/25.
//

import UIKit

extension UIAlertController {
    static func warningAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
        alert.addAction(cancelButton)
        viewController.present(alert, animated: true, completion: nil)
    }
}
