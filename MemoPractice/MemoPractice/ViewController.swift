//
//  ViewController.swift
//  MemoPractice
//
//  Created by Chae_Haram on 2022/01/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var memoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTableView.dataSource = self // memotableview의 데이터 소스 -> 데이터 변화 감지
        memoTableView.delegate = self   // memotableview의 델리게이트 -> 화면 액션 변화 감지
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memoTableView.reloadData()
    }

}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Memo.memoList.count
        // 데이터 부분, 셀을 몇개를 생성할지 결정함. 보통 유동적으로 사용하기 때문에 제일 주체가 될 수 있는 변수의 갯수로 하는경우가 많다.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableview reload")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "memoTableCell", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let memo = Memo.memoList[indexPath.row]
        cell.memoTitleLabel.text = memo.content
        cell.memoDateLabel.text = DateFormatter.customDateFormatter.string(from: memo.date)
        return cell
        // Reuseidentifier로 구분해 재사용 가능한 maintableviewcell 객체를 리턴하고 그 리턴값을 테이블에 추가하는 역할 리턴값이 없다면 uitableviewcell 자체를 리턴해 아무일도 안일어나게 함

    }
    
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        // 화면 셀의 크기를 90으로 고정하는 함수
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let memoVC = self.storyboard?.instantiateViewController(withIdentifier: "memoVC") as? MemoViewController else { return }
        memoVC.memo = Memo.memoList[indexPath.row]
        memoVC.rowNumber = indexPath.row
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.pushViewController(memoVC, animated: true)
        //열을 선택했을 때 어떤 동작을 수행할 지 나타냄
        //특정 셀이 클릭될 때, 클릭된 셀에 대한 정보를 다른 뷰컨으로 넘겨주고 싶을 때,
        //이 메서드를 사용해서 indexPath에 클릭된 셀에 대한 정보를 index에 담아서 넘겨줄 수 있다.
        //넘겨줄 뷰컨의 인스턴스를 생성해주고 navigationController의 pushViewController함수를 호출하면 된다.
    }
}
