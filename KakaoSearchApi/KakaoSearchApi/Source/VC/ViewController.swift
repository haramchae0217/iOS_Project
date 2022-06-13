//
//  ViewController.swift
//  KakaoSearchApi
//
//  Created by Chae_Haram on 2022/06/11.
//

import UIKit

/*
 숙제
 1. 이미지 o
 2. 검색했을 때 검색어에 따른 결과 테이블뷰 출력 o
 3. 셀을 누르면 상세 뷰가 나오고, 상세뷰에는 썸네일(thumbnail) 제목(title), 출판사(publisher), 작가(author), 줄거리(content)를 보여줄 것. o
 4. 검색실패하면 alert 처리하기 o
 도전 숙제
 5. 검색화면 결과 20개 o
 
 // 다음 수업
 - 라이브러리 api 사용하기
 - 프로젝트 고도화
 
 */

class ViewController: UIViewController {

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
        
        bookTableViewSet()
        searchBarSet()
    }
    
    func showAlert(code: Int, message: String) {
        let alert = UIAlertController(title: "\(code)", message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(okayButton)
        self.present(alert, animated: true)
    }
    
    func bookTableViewSet() {
        bookTableView.delegate = self
        bookTableView.dataSource = self
    }
    
    func searchBarSet() {
        let bookSearchBar = UISearchController(searchResultsController: nil)
        bookSearchBar.searchResultsUpdater = self
        bookSearchBar.searchBar.delegate = self
        bookSearchBar.searchBar.placeholder = "책 제목을 입력하세요."
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = bookSearchBar
    }
    
    func apiService(query: String) {
        APIService().searchBook(query: query, size: "20") { document, code in
            if code == 200 {
                guard let document = document else { return }
                self.bookList = document.documents
            } else {
                print("검색 실패",code)
                self.showAlert(code: code, message: "검색실패")
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        
        let book = bookList[indexPath.row]
        let imageUrl: URL = URL(string: book.thumbnail)!
        let imageData = try! Data(contentsOf: imageUrl)
        
        cell.bookImage.image = UIImage(data: imageData)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailBookViewController else { return }
        let detailBook = bookList[indexPath.row]
        detailVC.detailBook = detailBook
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let bookTitle = searchController.searchBar.text {
            print("검색어 : ",bookTitle)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let bookTitle = searchBar.text!
        apiService(query: bookTitle)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        bookList = []
    }
}
