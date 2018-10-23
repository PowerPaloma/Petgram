//
//  APIManager.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 22/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    
    static func getDataFrom(url: URL, completion: @escaping (Error?, Data?) -> Void){
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else { return }
            completion(nil, data)
            }.resume()
    }
    
    static func downloadImage(from urlSring: String) -> UIImage? {
        var uiimage: UIImage?
        guard let url = URL(string: urlSring) else {return nil}
        getDataFrom(url: url) { (erroe, data) in
            guard let data = data else {return }
            guard let image = UIImage(data: data) else {return}
            uiimage = image
        }
        
        return uiimage
    }
    
    static func getRandonFox(urlString: String = "https://randomfox.ca/floof/", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Fox.self, from:
                    data)
                guard let imageURL = model.image else {return}
                guard let image = downloadImage(from: imageURL) else {return}
                completion(nil, image)
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }
    
    static func getRandonDog(urlString: String = "https://random.dog/woof.json", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Dog.self, from:
                    data)
                guard let imageURL = model.url else {return}
                guard let image = downloadImage(from: imageURL) else {return}
                completion(nil, image)
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }
    
    static func getRandonCat(urlString: String = "https://aws.random.cat/meow", completion: @escaping (Error?, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response
            , error) in
            if error != nil {
                completion(error, nil)
            }
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(Cat.self, from:
                    data)
                guard let imageURL = model.file else {return}
                guard let image = downloadImage(from: imageURL) else {return}
                completion(nil, image)
            } catch let err {
                completion(err, nil)
            }
            }.resume()
    }

}
