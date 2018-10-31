//
//  FeedCollectionViewCell.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 24/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class FeedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postView: UIView!
    @IBOutlet weak var likeView: GradientView!
    @IBOutlet weak var buttonLike: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var saveView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var comentView: UIView!
    @IBOutlet weak var comentButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
        // Initialization code
    }
    
    func setup(){
        imagePet.clipsToBounds = true
        imagePet.layer.cornerRadius = imagePet.frame.width/2
        imagePet.contentMode = .scaleAspectFill
        likeView.layer.cornerRadius = likeView.frame.width/2
        likeView.clipsToBounds = true
        comentView.layer.cornerRadius = comentView.frame.width/2
        shareView.layer.cornerRadius = shareView.frame.width/2
        saveView.layer.cornerRadius = saveView.frame.width/2
       
        

     
    }

}
