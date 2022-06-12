//
//  BookTableViewCell.swift
//  KakaoSearchApi
//
//  Created by Chae_Haram on 2022/06/11.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    static let identifier = "BookCell"

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookContent: UILabel!
}
