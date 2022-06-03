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

struct RandomBeer: Decodable {
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
        fetchBeer()
    }
    
    // completion의 사용한 이유 ->
    // DispatchQueue를 사용한 이유 ->
    // main.sync를 사용하지 않은 이유 -> 
    
    func fetchBeer() {
        apiService{ beer, result in
            guard let beer = beer else {
                print(result)
                return
            }
            
            let imageURL: URL = URL(string: beer.image_url)!
            let imageData = try! Data(contentsOf: imageURL)
            
            DispatchQueue.main.async {
                self.beerName.text = beer.name
                self.tagLine.text = beer.tagline
                self.firstBrewed.text = beer.first_brewed
                self.beerDescription.text = beer.description
                self.abv.text = "\(beer.abv)"
                self.imageURL.image = UIImage(data: imageData)
            }
        }
    }
    
    func apiService(completion: @escaping (RandomBeer?, String) -> Void) { // 세션이 연결되어있으면 json형식을 원하는 형식으로 파싱해온다
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
                let beerInfo = try decoder.decode([RandomBeer].self, from: data)
                // decode 모델의 타입과, 어디서 온 데이터인지
                // 모델의 타입은 배열로 이루어져있음.
                
                completion(beerInfo[0], "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패") // 실패했을때 nil값을 넘길거라 Beer?타입
            }
        }.resume() // 데이터 통신을 시작해! 안써주면 작동을 안함.
    }
    
    @IBAction func refreshButtonClicked(_ sender: UIBarButtonItem) {
        fetchBeer()
    }
    
    @IBAction func beerListButtonClicked(_ sender: UIBarButtonItem) {
        guard let beerListVC = self.storyboard?.instantiateViewController(withIdentifier: "beerListVC") as? BeerViewController else { return }
        self.navigationController?.pushViewController(beerListVC, animated: true)
    }
}

// 내용 정리
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

// thread

/*
 GCD = Grand Central Dispatch - 비동기 / 동기적으로 네트워크를 처리 해주는일
 DispatchQueue
 - task를 정의하면 OS가 알아서 적절한 thread에 task를 뿌려줌
 - 그걸 main에서 처리해줄것인지, background(global)에서 처리해줄것인지 선택하거나
 - 직력로 처리할지, 병렬로 처리할지 선택한다.
 
 - main은 대표적으로 ui갱신하는 일을 함
 - main이 다른일을 하면 view를 그려주는 일을 멈추기 때문
 - 그래서 ui도 업데이트하고 작업도 해야한다면
 - main에 ui를 업데이트하는 일을 주고
 - global에 나머지 일을 준다.
 - main은 단 하나만 존재(하나의 큐 안에), 직렬로 이루어져 있음. 하나기때문에 병렬적인 처리가 불가능함.
 - global은 main이 아닌 모든 작업을 처리해줄때 사용. 병렬적 처리가 가능함, 직렬처리도 물론 가능함.
 - 직렬이 아닌 병렬로 보통 처리를 함.(끝나는 시점을 알 수 없음)
 - 끝나는 시점에 끝났음을 알기위해 completion을 사용.
 
 - thread와 process에 관련된 공부
 
 어떤 작업을 queue한다
 queue : FIFO 선입선출
 stack : LIFO 후입선출
 
 [Task] -> Queue[t1, t2, t3, ...] 알아서 처리해줌
 
 thread : main, background
 main queue : 눈에 보이는 UI를 업데이트 해줌 다른 thread에선 할 수 없음
 global queue : UI를 제외한 나머지 작업을 해줌(network 통신 등), 우선순위를 정해줄 수 있음.
 custom queue : 직렬로 만들지 병렬로 만들지 결정. default는 직렬값.
 심플한 구조의 queue는
 
 직렬 / 병렬
 
 q1, q2, q3
 [t1, t2, t3, t4]
 
 직렬 : 일처리는 느리지만, 원하는 순서대로 일처리를 끝낼 수 있음. 순서 보장
 ex) 이미지 다운 이후 필터 처리 -> 직렬 처리 가능
 but) 병렬 처리라면 이미지 다운 이전에 필터 처리가 먼저 일어날 가능성이 존재함.
 ∴ 이런 순서를 잘 따져가며 직렬 병렬 선택
 MARK: 결론 : cs 공부...!
 print찍어가면서 스스로 순서찾아보기
 
 QoS : Quality of Service
 5단계로 형성
 가운데가 default
 
 main - async처리만 하기 sync처리 x
 main의 task가 a,b,c,d가 있는데
 a를 하던 도중 a하지말고 b를 해!
 라고 하면 이건 main스스로 멈추라고 하는것과 다를게 없음.
 dead lock
 main은 단 하나기 때문에 자기 자신한테 sync처리 불가
 강아지한테 밥 기다려 하는걸 자신한테 하고 밥먹길 기다리는것과 같음.
 
 main한테 sync를 처리하는것은 자기 자신에게 일을 멈추는것도 하는것도 아니기 때문에 dead lock 발생
 
 global은 여러개기 때문에 sync처리가 가능
 
 결국은 여러개의 작업을 최고의 효율을 내면서 작동하게 하기 위함.
 
 q1 [t1, t2, t3, t4]
 q2 []
 q3 []
 
 병렬 : 일처리는 빠르지만, 일처리 끝나는 시점을 알 수 없음.
 q1 [t1]
 q2 [t2]
 q3 [t3, t4]
 
 main : UI만 담당
 global : 이미지 다운
 
 */

// 인코더블, 디코더블 => 프로토콜
// 인코딩 => 데이터를 만들고 인코드를 하면 Json형식으로 만들어줌
// 디코딩 => Json형식을 디코드하면 데이터로 만들어줌

//protocol Eat { // 청사진 blue print = 설계도면 : 여기 안에있는 것들은 무조건 필수적으로 있어야 하는것들.
//    func drinkWater()
//    func getSpoon()
//}
//
//class Dinner: Eat { // : Eat 프로토콜은 준수했다.
//    func drinkWater() {
//        <#code#>
//    }
//    func getSpoon() {
//        <#code#>
//    }
//}

