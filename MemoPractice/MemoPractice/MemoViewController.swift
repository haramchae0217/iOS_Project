//
//  MemoViewController.swift
//  MemoPractice
//
//  Created by Chae_Haram on 2022/01/27.
//

import UIKit

class MemoViewController: UIViewController {

    @IBOutlet weak var memoTextView: UITextView!
    
    var memo: Memo?
    var rowNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        createRightBarButtonItem()
        memoTextView.text = memo?.content
        
    }
    
    func createRightBarButtonItem() {
        let rightBarButton: UIBarButtonItem = UIBarButtonItem(title: "수정하기",style: .done, target: self, action: #selector(updateButtonClicked))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func updateButtonClicked() {
        
        // 1. content가 변경되었는지 체크
        
        guard let memo = memo else { return }
        if memo.content == memoTextView.text {
            UIAlertController.showAlert(message: "변경사항이 없습니다.\n변경 후 다시 시도해주세요.", vc: self)
            return
        }
        // 3. 변경할 메모 추가하기
        // 새로운 메모 정보를 담을 변수 선언
        let newMemo = Memo(content: memoTextView.text)
        
        // 2. row번째의 해당하는 메모리스트의 메모를 삭제
        if let row = rowNumber {
            Memo.memoList.remove(at: row)
            Memo.memoList.append(newMemo)
        }
        
        
        self.navigationController?.popViewController(animated: true)
            //didselectrowat이랑 비슷
            //cell이 아닌 button을 눌렀을 때 발생하는 동작 기입
    }

}


// 복습
// viewLifeCycle - 시점
// static keyword - 프로퍼티 3종류
