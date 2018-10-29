//
//  ParserTextField.swift
//  Social Networking for Animals
//
//  Created by Paloma Bispo on 23/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit

class RegisterManager {
    
    static func checkTextFieldIsEmpty(textFields: [UITextField]) -> Bool{
        for textField in textFields{
            if textField.text == "" {
                return true
            }
        }
        return false
    }
    
    static func validateRegister(username: String) -> Bool{
        let predicate = NSPredicate(format: "username == %@", username)
        guard let result = DataManager.executeThe(query: predicate, forEntityName: "User") as? [User] else {return false}
        
        if result.isEmpty {
            return true
        }else{
            return false
        }
        
    }
    
    static func saveNewUser(username: String, password: String, email: String, photo: UIImage?) -> User{
        print("ok")
        let newUser = User(context: DataManager.getContext())
        newUser.username = username
        newUser.password = password
        newUser.email = email
        guard let imageUser = photo else {
            guard let imageDefault = UIImage(named: "user") else {
                newUser.photo = ""
                DataManager.saveContext()
                return newUser
            }
            newUser.photo = StoreManager.saving(image:imageDefault, withName:"\(imageDefault.hash)")
            DataManager.saveContext()
            return newUser
        }
        newUser.photo = StoreManager.saving(image:imageUser, withName: imageUser.accessibilityIdentifier ?? "\(imageUser.hashValue)")
        DataManager.saveContext()
        return newUser
        
    }
    
    static func validateEmail(email: String, completion: @escaping (Error?, Bool, String?) -> Void){
        APIManager.validate(emailAddress: email) { (error, isValid, emailSuggestion) in
            if !(error == nil){
                DispatchQueue.main.async {
                    completion(error, false, nil)
                }
            }
            guard let isValid = isValid else {
                DispatchQueue.main.async {
                    completion(error, false, nil)
                }
                return
            }
            if isValid {
                DispatchQueue.main.async {
                    completion(nil, true, nil)
                }
            }else{
                DispatchQueue.main.async {
                    completion(nil, false, emailSuggestion)
                }
            }
        }
        
    }
}
