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
    @IBOutlet weak var capsuleView: UIView!
    
    var item: SearchElement! {
        didSet{
            capsuleView.backgroundColor = UIColor(red: 0.90, green: 0.90, blue: 0.92, alpha: 1.00)
            filmImage.isHidden = false
            filmTitle.text = item.title
            filmImage.kf.indicatorType = .activity
            capsuleView.addShadowAndOverlay(px: 15, color: .gray)
            if let url =  URL(string: item.poster ?? String()) {
                filmImage.kf.setImage(with: url)
            }
        }
    }
    
    var emptyItem: String!{
        didSet{
            capsuleView.backgroundColor = .white
            filmTitle.text = emptyItem
            filmImage.isHidden = true
            capsuleView.addShadowAndOverlay(px: 0, color: .white)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
