//
//  APIManager.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    
    static func downloadImage(from urlSring: String, completion: @escaping (UIImage?, Error?) -> Void) {
        
        guard let url = URL(string: urlSring) else {return}
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            guard let image = UIImage(data: data) else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DispatchQueue.main.async {
                completion(image, nil)
            }
            }.resume()
        
    }
    
    static func getRandonFox(urlString: String = "https://randomfox.ca/floof/", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(error, nil)
                }
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(error, nil)
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Fox.self, from:
                    data)
                guard let imageURL = model.image else {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                    return
                    
                }
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                    }
                    guard let image = image else {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                })
    
            } catch let err {
                DispatchQueue.main.async {
                    completion(err, nil)
                }
            }
            }.resume()
    }
    
    static func getRandonDog(urlString: String = "https://random.dog/woof.json", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(error, nil)
                }
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Dog.self, from:
                    data)
                guard let imageURL = model.url else {return}
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                    }
                    guard let image = image else {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                })
            } catch let err {
                DispatchQueue.main.async {
                    completion(err, nil)
                }
            }
            }.resume()
    }
    
    static func getRandonCat(urlString: String = "https://aws.random.cat/meow", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(error, nil)
                }
            }
            guard let data = data else {return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Cat.self, from:
                    data)
                guard let imageURL = model.file else {return}
                downloadImage(from: imageURL, completion: { (image, error) in
                    if error != nil {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                    }
                    guard let image = image else {
                        DispatchQueue.main.async {
                            completion(error, nil)
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                })
            } catch let err {
                DispatchQueue.main.async {
                    completion(err, nil)
                }
            }
            }.resume()
    }
    
    static func validate(emailAddress email: String, completion: @escaping (Error?, Bool?, String?) -> Void) {
        
        
        let urlString = "https://apilayer.net/api/check?access_key=be95a2c215d4c5e3de2ee79d8322034e&email=\(email)&smtp=1&format=1"
        guard let url = URL(string: urlString) else {return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                DispatchQueue.main.async {
                    completion(error, false, nil)
                }
                
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(error, false, nil)
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(EmailValidate.self, from:data)
                guard let mxFound = model.mxFound else{
                    DispatchQueue.main.async {
                        completion(nil, false, nil)
                    }
                    return
                }
                guard let isValid = model.formatValid else {
                    DispatchQueue.main.async {
                        completion(nil, false, nil)
                    }
                    return
                }
                if  isValid && mxFound{
                    DispatchQueue.main.async {
                        completion(nil, true, nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, false, model.didYouMean)
                    }
                }
            } catch let err {
                DispatchQueue.main.async {
                    completion(err, false, nil)
                }
            }
            }.resume()
        
    }
    
    
    static func getRandonAnimal(completion: @escaping (Error?, UIImage?) -> Void) {
        let rand = Int.random(in: 0...2)
        switch rand {
        case 0 :
            APIManager.getRandonCat { (error, image) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                    
                }
            }
        case 1 :
            APIManager.getRandonDog { (error, image) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                }
            }
        case 2 :
            APIManager.getRandonFox { (error, image) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                }
            }
        
        default:
            APIManager.getRandonDog { (error, image) in
                if error != nil {
                    DispatchQueue.main.async {
                        completion(error, nil)
                    }
                }else{
                    DispatchQueue.main.async {
                        completion(nil, image)
                    }
                }
            }
        }
    }


}
