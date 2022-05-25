//
//  ViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/05/25.
//

import UIKit

/*
 API 사용법
 무료 랜덤 API 사용
 
 API를 통해 가져온 JSON 데이터로부터 원하는 정보를 뽑으려면
 그 정보들로 이루어진 모델이 필요하다.
 
 내가 원하는 정보들만 담은 모델을 먼저 만들어줘야함.
 이때 이름이 똑같아야함
 
 :name, tagline, first_brewed, description, image_url, abv
 
 데이터 통신하는 두가지 : 1. 라이브러리, 2. urlsession
 
 String -> URL타입으로 변경해줘야함
 
 인터넷에서 가져온 데이터를 우리가 원하는 형태로 바꾸는 것 -> decode -> decoder -> Decodable
 decode를 하기 위해서 decoder를 사용해야함
 decoder를 사용하려면 모델이 decodable을 준수해야함
 
 */

struct Beer: Decodable {
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let image_url: String
    let abv: Float
}

class ViewController: UIViewController {

    @IBOutlet weak var imageURL: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var firstBrewed: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var abv: UILabel!
    
    
    let url: URL = URL(string: "https://api.punkapi.com/v2/beers/random")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService{ beer, result in
            print(beer?.name)
            print(beer?.tagline)
            print(beer?.first_brewed)
            print(beer?.description)
            print(beer?.abv)
//            self.beerName.text = beer?.name
//            self.tagLine.text = beer?.tagline
//            self.firstBrewed.text = beer?.first_brewed
//            self.beerDescription.text = beer?.description
//            self.abv.text = "\(beer?.abv)"
        }
        
    }
    
    func apiService(completion: @escaping (Beer?, String) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }

            guard let data = data else { return }

//            print("data : ",String(bytes: data, encoding: .utf8)) // 데이터 시각화
            
            do {
                let decoder = JSONDecoder()
                let beerInfo = try decoder.decode([Beer].self, from: data)
                
                completion(beerInfo[0], "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패")
            }
            
        }.resume()
    }
    
    
}

