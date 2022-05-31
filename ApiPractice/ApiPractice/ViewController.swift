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
} // api에서 제공하는 데이터 이름

class ViewController: UIViewController {

    @IBOutlet weak var imageURL: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var tagLine: UILabel!
    @IBOutlet weak var firstBrewed: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var abv: UILabel!
    
    
    let url: URL = URL(string: "https://api.punkapi.com/v2/beers/random")! // 랜덤한 맥주 정보를 받아오는 주소
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiService{ beer, result in
            print(beer?.name)
            print(beer?.tagline)
            print(beer?.first_brewed)
            print(beer?.description)
            print(beer?.abv)
        }
    }
    
    func apiService(completion: @escaping (Beer?, String) -> Void) { // 세션이 연결되어있으면 json형식을 원하는 형식으로 파싱해온다
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse else { return }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)") // 데이터 => 2068byte 이런식 => 0101001,,,
                return
            }

            guard let data = data else { return }
//            print("data : ",String(bytes: data, encoding: .utf8)) // 데이터 010101000 => 시각화
            
            do {
                let decoder = JSONDecoder()
                let beerInfo = try decoder.decode([Beer].self, from: data)
                // decode 모델의 타입과, 어디서 온 데이터인지
                // 모델의 타입은 배열로 이루어져있음.
                
                completion(beerInfo[0], "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패") // 실패했을때 nil값을 넘길거라 Beer?타입
            }
            
            /* do catch 오류를 잡아냄
             try구문에서 던진 오류를 catch문에서 잡는다.
             do {
                try expression
             } catch pattern 1 {
                statements
             } catch pattern 2 {
                statements
             }
             try문에서 오류가 나면 catch문으로 가서 catch문 실행
             try문에서 오류가 나지 않으면 catch문 생략
             */
            
            /*
             completion - 클로져
             일종의 함수의 형태, 함수보다 큼
             클로져의 형태는 3-4개가 있다. 그 중 하나가 함수
            
             func 함수이름(인자명: 타입명) -> 리턴타입 {
             
             }
             
             () -> void 이부분이 클로져
             
             값을 캡쳐한다. -> 복제
             
             이스케이핑 클로져
             함수가 실행되고 나서 결과물이 나오고 나면 그때 그 블록을 탈출하라고 알려줘~
             
             func escapingFunction(completion: @escaping (String) -> Void) {
                print("함수시작")
                completion("함수 밖으로 보내줄 값") // 이 뜻이 escapingFunction을 시행하는것
                print("함수 끝")
             }
             escapingFunction { result in
                print("escaping 시작")
                print(result)
                print("escaping 끝")
             }
             
             출력 순서는
             함수시작
             escaping 시작
             함수 밖으로 보내줄 값
             escaping 끝
             함수 끝
             
             */
            
        }.resume() // 데이터 통신을 시작해! 안써주면 작동을 안함.
    }
    
    
}

// 인코더블, 디코더블 => 프로토콜
// 인코딩 => 데이터를 만들고 인코드를 하면 Json형식으로 만들어줌
// 디코딩 => Json형식을 디코드하면 데이터로 만들어줌

protocol Eat { // 청사진 blue print = 설계도면 : 여기 안에있는 것들은 무조건 필수적으로 있어야 하는것들.
    func drinkWater()
    func getSpoon()
}

class Dinner: Eat { // : Eat 프로토콜은 준수했다.
    func drinkWater() {
        <#code#>
    }
    func getSpoon() {
        <#code#>
    }
}

