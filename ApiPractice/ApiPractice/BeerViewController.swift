//
//  BeerViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/05/31.
//

import UIKit

struct Beer: Decodable {
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let image_url: String
    let abv: Float
    
    var beerList: [Beer] = []
}

class BeerViewController: UIViewController {

    @IBOutlet weak var beerListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beerListTableView.delegate = self
        beerListTableView.dataSource = self
    }
    
    // api 통신하기
}

extension BeerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
//        cell.beerImage.image =
//        cell.beerName.text =
//        cell.beerDescription.text =
        
        // decode한 데이터 tableview에 뿌려주기
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 갯수 뽑아오기
        return 0
    }
}

extension BeerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
