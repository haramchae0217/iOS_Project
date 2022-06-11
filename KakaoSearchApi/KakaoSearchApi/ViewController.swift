//
//  ViewController.swift
//  KakaoSearchApi
//
//  Created by Chae_Haram on 2022/06/11.
//

import UIKit

/*
 숙제
 1. 이미지
 2. 검색했을 때 검색어에 따른 결과 테이블뷰 출력
 3. 셀을 누르면 상세 뷰가 나오고, 상세뷰에는 썸네일(thumbnail) 제목(title), 출판사(publisher), 작가(author), 줄거리(content)를 보여줄 것.
 4. 검색실패하면 alert 처리하기
 도전 숙제
 5. 검색화면 결과 20개
 */

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var bookTableView: UITableView!
    
    var bookList: [Book] = [] {
        didSet { // 값이 변경된다면 작동
            DispatchQueue.main.async {
                self.bookTableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService().searchBook(query: "귀신") { document, code in
            if code == 200 {
                guard let document = document else { return }
                self.bookList = document.documents
            } else {
                print("검색 실패",code) // alert 처리
            }
        }
        
        bookTableView.delegate = self
        bookTableView.dataSource = self
        
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookList[indexPath.row]
        cell.bookTitle.text = book.title
        cell.bookContent.text = book.contents
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
