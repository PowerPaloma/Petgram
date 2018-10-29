//
//  DetailsViewController.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 29/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var imagePet: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var imagePost: UIImageView!
    
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let post = self.post{
            self.petName.text = post.pet?.name
            self.userName.text = post.pet?.owner?.username
            guard let imagePet = post.pet?.photo else {return}
            self.imagePet.image = StoreManager.loadImageFromPath(imagePet)
            guard let imagePost = post.photo else {return}
            self.imagePost.image = StoreManager.loadImageFromPath(imagePost)
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
