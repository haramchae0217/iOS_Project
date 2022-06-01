//
//  BeerViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/05/31.
//

import UIKit

struct Beer: Decodable {
    var name: String
    var description: String
    var abv: Float
    var image_url: String
}

class BeerViewController: UIViewController {

    @IBOutlet weak var beerListTableView: UITableView!
    
    var beerList: [Beer] = []
    let url: URL = URL(string: "https://api.punkapi.com/v2/beers")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appendBeer()
        
        beerListTableView.delegate = self
        beerListTableView.dataSource = self
    }
    
    // api 통신하기
    
    func appendBeer() {
        apiSet{ beer, result in
            guard let beer = beer else {
                print("result : \(result)")
                return
            }
            let beerInfo = Beer(name: beer.name, description: beer.description, abv: beer.abv, image_url: beer.image_url)
            self.beerList.append(beerInfo)
            print(beerInfo)
        }
    }
        
    func apiSet(completion: @escaping (Beer?, String) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let beerInfo = try decoder.decode([Beer].self, from: data)
                for i in 0..<25 {
                    completion(beerInfo[i], "데이터 통신 완료")
                }
                DispatchQueue.main.async {
                    self.beerListTableView.reloadData()
                }
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }
}

extension BeerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = beerList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
        let imageURL: URL = URL(string: row.image_url)!
        let imageData = try! Data(contentsOf: imageURL)
        
        cell.beerName.text = row.name
        cell.beerDescription.text = row.description
        cell.beerAbv.text = "\(row.abv)"
        cell.beerImage.image = UIImage(data: imageData)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
}

extension BeerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
