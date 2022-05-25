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
 
 */

struct Beer {
    let name: String
    let tagline: String
    let first_brewed: String
    let description: String
    let image_url: String
    let abv: Float
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

