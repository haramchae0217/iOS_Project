//
//  BeerTableViewCell.swift
//  ApiPractice
//
//  Created by Chae_Haram on 2022/05/31.
//

import UIKit

class BeerTableViewCell: UITableViewCell {
    
    static let identifier = "BeerCell"
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var beerAbv: UILabel!
}
