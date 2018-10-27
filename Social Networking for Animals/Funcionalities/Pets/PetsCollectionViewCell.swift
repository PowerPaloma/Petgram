//
//  PetsCollectionViewCell.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 25/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class PetsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var moreImageView: UIImageView!
    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var namePet: UILabel!
    @IBOutlet weak var kindAnimal: UILabel!
    @IBOutlet weak var photosCount: UILabel!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
