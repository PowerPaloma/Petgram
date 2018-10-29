//
//  PreviewViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 29/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var imagePost: UIImageView!
    @IBOutlet weak var petName: UILabel!
    
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let post = self.post {
            guard let imagePet = post.pet?.photo else {return}
            self.imagePet.image = StoreManager.loadImageFromPath(imagePet)
            self.imagePet.clipsToBounds = true
            self.imagePet.layer.cornerRadius = self.imagePet.frame.width/2
            guard let imagePost = post.photo else {return}
            self.imagePost.image = StoreManager.loadImageFromPath(imagePost)
            self.petName.text = post.pet?.name
        }

        // Do any additional setup after loading the view.
    }
    

    override var previewActionItems: [UIPreviewActionItem] {
        let likeAction = UIPreviewAction(title: "Like", style: .default,
                                         handler: { previewAction, viewController in
                                            
                                            
        })
        
        let shareAction = UIPreviewAction(title: "Share", style: .default,
                                           handler: { previewAction, viewController in
                                            
                                            
                                            
        })
        
        let saveAction = UIPreviewAction(title: "Save Image", style: .default,
                                          handler: { previewAction, viewController in
                                           
        })
        
        return [saveAction, shareAction, likeAction]
        
    }


}
