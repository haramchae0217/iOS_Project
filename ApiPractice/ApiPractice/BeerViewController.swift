//
//  BeerViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/05/31.
//

import UIKit

struct Beer: Decodable { // struct는 상속x 상속이 가능하다면 class
    let name: String
    let description: String
    let abv: Float
    let imageUrl: String // snake case사용, but swift는 camel case를 사용
    
    enum CodingKeys: String, CodingKey {
        case name, description, abv
        case imageUrl = "image_url"
    }
    // 인스턴스를 생성할 때 초기값을 넣어서 만들어줄 것이기 때문에 let으로도 충분합니다.
} // Decodable : json형식으로된 데이터를 내가 원하는 형태의 데이터로 파싱해주기 위해 Decodable을 준수. xml은 불가능

struct Constant {
    static let cellHeight: CGFloat = 120
}

class BeerViewController: UIViewController {

    @IBOutlet weak var beerListTableView: UITableView!
    
    var beerList: [Beer] = []
    let url: URL = URL(string: "https://api.punkapi.com/v2/beers")!
    // 인터넷과 http통신을 할 때
    
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
            let beerInfo = Beer(name: beer.name, description: beer.description, abv: beer.abv, imageUrl: beer.imageUrl)
            self.beerList.append(beerInfo)
        }
    }
        
    func apiSet(completion: @escaping (Beer?, String) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            // URLSession이 하는 역할 : 앱과 서버 간의 데이터를 주고 받기 위해 HTTP 프로토콜을 이용해서 데이터를 주고 받기 위해 애플이 제공하는 API입니다.
            // HTTP : HyperText Transfer Protocol 인터넷 통신 규약 - html,,,
            // Https :
            // tcp / ip :
            // 클라이언트가 지정한 url에게 request를 하고 서버측에게 날아오는 response
            
            guard let response = response as? HTTPURLResponse else { return }
                // http url response를 캐스팅,, 이상한 값이 들어왔나 체크,,,
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            
            guard let data = data else { return }
            // 2진수에 대한 byte 값
            
            do { // byte값을 알아볼 수 있는 데이터로 바꿔줘야하기 때문에 decode를 함
                let decoder = JSONDecoder()
                let beerInfo = try decoder.decode([Beer].self, from: data)
                // completion을 한 번만 사용하고 고쳐보기
                for i in 0..<beerInfo.count {
                    completion(beerInfo[i], "데이터 통신 완료")
                }
                DispatchQueue.main.async {
                    self.beerListTableView.reloadData()
                }
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume() // 까먹지말기 통신시작 안함.
    }
}

extension BeerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
        
        let row = beerList[indexPath.row]
        let imageURL: URL = URL(string: row.imageUrl)!
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
        return Constant.cellHeight
    }
}
