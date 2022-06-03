//
//  TranslateViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/06/03.
//

import UIKit


// 카카오 번역 api를 통해 originalTextView에 입력한 내용을 번역한 문장이 translatedLabel에 보이도록 구현하기
class TranslateViewController: UIViewController {

    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var translatedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        
    }
    
}
