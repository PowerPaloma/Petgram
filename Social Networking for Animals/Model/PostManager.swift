//
//  PostManager.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 28/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class PostManager: NSObject {
    
    static func getImage(from image: UIImage?) -> UIImage? {
        guard let image = image else {
            guard let imageDefault = UIImage(named: "Cat") else {return nil}
            return imageDefault
        }
        return image
    }
    
    
    static func newPost(){
        let newPost = Post(context: DataManager.getContext())
        guard let entity = DataManager.getEntity(entity: "Pet") else {return}
        let result = DataManager.getAll(entity: entity)
        if result.success {
            guard let pets = result.objects as? [Pet] else {return}
            newPost.pet = pets.randomElement()
            let rand = Int.random(in: 0...2)
            switch rand {
            case 0 :
                DispatchQueue.main.async {
                    APIManager.getRandonFox { (error, image) in
                        if !(error == nil){
                            print("ERROR")
                            return
                        }
                        guard let imagePost = self.getImage(from: image) else{
                            newPost.photo = ""
                            return
                        }
                        newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                    }
                }
                
            case 1 :
                 DispatchQueue.main.async {
                    APIManager.getRandonDog { (error, image) in
                        if !(error == nil){
                            return
                        }
                        guard let imagePost = self.getImage(from: image) else{
                            newPost.photo = ""
                            return
                        }
                        newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                    }
                }
            case 2 :
                DispatchQueue.main.async {
                    APIManager.getRandonCat { (error, image) in
                        if !(error == nil){
                            return
                        }
                        guard let imagePost = self.getImage(from: image) else{
                            newPost.photo = ""
                            return
                        }
                        newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                    }
                }
                
            default:
                guard let imageDefault = UIImage(named: "Cat") else{
                    newPost.photo = ""
                    return
                }
                newPost.photo = StoreManager.saving(image: imageDefault, withName: "post")
            }
        }
        DataManager.saveContext()
        
    }

}
