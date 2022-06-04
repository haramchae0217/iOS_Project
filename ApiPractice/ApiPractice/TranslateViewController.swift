//
//  TranslateViewController.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/06/03.
//

import UIKit

struct Translate: Decodable {
    let translatedText: [[String]]

    enum CodingKeys: String, CodingKey {
        case translatedText = "translated_text"
    }
}

// 카카오 번역 api를 통해 originalTextView에 입력한 내용을 번역한 문장이 translatedLabel에 보이도록 구현하기
class TranslateViewController: UIViewController {

    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var translatedLabel: UILabel!
    
    let get = "https://dapi.kakao.com/v2/translation/translate?src_lang=kr&target_lang=en&query="
    let apiKey = "60bca9a912ff21d8f05cb72a1bd67d5d"
    var query = ""
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func translateLanguage() {
        apiSet { translate, result in
            guard let translate = translate else {
                print("result : \(result)")
                return
            }
            print(translate)
        }
    }
    
    func apiSet(completion: @escaping (Translate?, String) -> Void) {
        URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            guard response.statusCode == 200 else {
                completion(nil, "데이터 통신 실패 : \(response.statusCode)")
                return
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let translate = try decoder.decode([Translate].self, from: data)
                completion(translate[0], "데이터 통신 완료")
            } catch {
                completion(nil, "decode 실패")
            }
        }.resume()
    }

    @IBAction func translateButtonClicked(_ sender: UIButton) {
        query = ""
        query = originalTextView.text
        url = URL(string: get+apiKey+query)!
        print(url)
        print(query)
        
        translateLanguage()
    }
    
}
