//
//  DetailBookViewController.swift
//  KakaoSearchApi
//
//  Created by Chae_Haram on 2022/06/13.
//

import UIKit

class DetailBookViewController: UIViewController {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookContent: UILabel!
    
    var detailBook: Book?
    var author: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        guard let detailBook = detailBook else { return }

        for data in detailBook.authors {
            author += data
        }
        DetailbookSet()
    }
    func DetailbookSet() {
        if let detailBook = detailBook {
            bookImage.image = UIImage(named: detailBook.thumbnail)
            bookTitle.text = detailBook.title
            bookPublisher.text = detailBook.publisher
            bookAuthor.text = author
            bookContent.text = detailBook.contents
        }
    }

}
