//
//  UpCollectionViewCell.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 18/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class TopShelfCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCategory: UILabel!
    @IBOutlet weak var imageBackgound: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        // Initialization code
    }
    
    func setup(){
        imageBackgound.clipsToBounds = true
        imageBackgound.layer.cornerRadius = 10
    }

}
