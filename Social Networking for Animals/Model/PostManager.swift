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
    
    static func newPost(completion: @escaping (Post?, Error?) -> Void){
        let rand = Int.random(in: 0...2)
        switch rand {
        case 0 :
            APIManager.getRandonCat { (error, image) in
                if !(error == nil){
                    print("error in randon cat")
                    completion(nil, error)
                    return
                }
                let newPost = Post(context: DataManager.getContext())
                guard let entity = DataManager.getEntity(entity: "Pet") else {return}
                let result = DataManager.getAll(entity: entity)
                if result.success {
                    guard let pets = result.objects as? [Pet] else {return}
                    newPost.pet = pets.randomElement()
                }else{
                    completion(nil, error)
                }
                guard let imagePost = self.getImage(from: image) else{
                    newPost.photo = ""
                    completion(nil, error)
                    return
                }
                newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                completion(newPost, nil)
            }
            break
        case 1 :
            APIManager.getRandonDog { (error, image) in
                if !(error == nil){
                    print("error in randon dog")
                    completion(nil, error)
                    return
                }
                let newPost = Post(context: DataManager.getContext())
                guard let entity = DataManager.getEntity(entity: "Pet") else {return}
                let result = DataManager.getAll(entity: entity)
                if result.success {
                    guard let pets = result.objects as? [Pet] else {return}
                    newPost.pet = pets.randomElement()
                }else{
                    completion(nil, error)
                }
                guard let imagePost = self.getImage(from: image) else{
                    newPost.photo = ""
                    completion(nil, error)
                    return
                }
                newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                completion(newPost, nil)
            }
            break
        case 2 :
            APIManager.getRandonFox { (error, image) in
                if !(error == nil){
                    print("error in randon fox")
                    completion(nil, error)
                    return
                }
                let newPost = Post(context: DataManager.getContext())
                guard let entity = DataManager.getEntity(entity: "Pet") else {return}
                let result = DataManager.getAll(entity: entity)
                if result.success {
                    guard let pets = result.objects as? [Pet] else {return}
                    newPost.pet = pets.randomElement()
                }else{
                    completion(nil, error)
                }
                guard let imagePost = self.getImage(from: image) else{
                    newPost.photo = ""
                    completion(nil, error)
                    return
                }
                newPost.photo = StoreManager.saving(image: imagePost, withName: "post")
                completion(newPost, nil)
            }
            break
    
        default:
            completion(nil, NSError(domain: "", code: 0, userInfo: nil))
        
        }
    }

}
