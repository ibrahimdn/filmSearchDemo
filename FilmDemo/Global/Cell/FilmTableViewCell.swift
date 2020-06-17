//
//  FilmCellViewController.swift
//  FilmDemo
//
//  Created by İbrahim DOĞAN on 6/16/20.
//  Copyright © 2020 ibrahimdn. All rights reserved.
//

import UIKit
import Kingfisher

class FilmTableViewCell: UITableViewCell {

    @IBOutlet weak var filmImage: UIImageView!
    @IBOutlet weak var filmTitle: UILabel!
    
    var item: SearchElement! {
        didSet{
            filmTitle.text = item.title
            filmImage.kf.indicatorType = .activity
            if let url =  URL(string: item.poster ?? String()) {
                filmImage.kf.setImage(with: url)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
