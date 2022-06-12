//
//  Book.swift
//  KakaoSearchApi
//
//  Created by Chae_Haram on 2022/06/11.
//

import Foundation

struct Book: Decodable {
    let thumbnail: String
    let title: String
    let publisher: String
    let authors: [String]
    let contents: String
}

struct Document: Decodable {
    let documents: [Book]
}
